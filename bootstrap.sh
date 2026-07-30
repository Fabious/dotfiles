#!/usr/bin/env bash
# Provisions a fresh Linux machine to match this repo.
#
# Portable across distros: only the `packages` step uses the native package
# manager (apt / pacman / dnf / zypper / apk are detected). Every other step
# installs from upstream tarballs, official install scripts, cargo, or git,
# so it behaves the same everywhere. x86_64 and aarch64 are both supported.
#
# Idempotent: every step skips if the tool is already present. Safe to re-run.
#
#   ./bootstrap.sh                 # everything
#   ./bootstrap.sh packages cargo  # only the named steps
#   ./bootstrap.sh --list          # show step names

set -euo pipefail

readonly LOCAL_BIN="$HOME/.local/bin"

have() { command -v "$1" >/dev/null 2>&1; }
log()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
skip() { printf '    \033[2m%s already installed\033[0m\n' "$1"; }
warn() { printf '    \033[1;33m!\033[0m %s\n' "$*" >&2; }

# RUST_TRIPLE: bat, fd.   GOARCH: gh, asdf.   LAZYGIT_ARCH: lazygit only.
detect_arch() {
  case "$(uname -m)" in
    x86_64|amd64)
      RUST_TRIPLE=x86_64-unknown-linux-gnu; GOARCH=amd64; LAZYGIT_ARCH=x86_64 ;;
    aarch64|arm64)
      RUST_TRIPLE=aarch64-unknown-linux-gnu; GOARCH=arm64; LAZYGIT_ARCH=arm64 ;;
    *)
      echo "Unsupported architecture: $(uname -m) (need x86_64 or aarch64)." >&2
      exit 1 ;;
  esac
  readonly RUST_TRIPLE GOARCH LAZYGIT_ARCH
}

detect_pm() {
  if   have apt-get; then PM=apt
  elif have pacman;  then PM=pacman
  elif have dnf;     then PM=dnf
  elif have zypper;  then PM=zypper
  elif have apk;     then PM=apk
  else
    echo "No supported package manager found (apt/pacman/dnf/zypper/apk)." >&2
    echo "Install these by hand, then re-run skipping 'packages':" >&2
    echo "  fish git-delta ripgrep lsd jq keychain vim curl unzip fontconfig cc" >&2
    exit 1
  fi
  readonly PM
}

# Canonical name -> package name for the detected manager. Empty means "same".
pkg_name() {
  local canonical="$1"
  case "$canonical:$PM" in
    toolchain:apt)     echo build-essential ;;
    toolchain:pacman)  echo base-devel ;;
    toolchain:dnf)     echo gcc ;;
    toolchain:zypper)  echo gcc ;;
    toolchain:apk)     echo build-base ;;
    git-delta:apk)     echo delta ;;
    *)                 echo "$canonical" ;;
  esac
}

pm_install() {
  case "$PM" in
    apt)    sudo apt-get update && sudo apt-get install -y "$@" ;;
    pacman) sudo pacman -Sy --needed --noconfirm "$@" ;;
    dnf)    sudo dnf install -y "$@" ;;
    zypper) sudo zypper --non-interactive install "$@" ;;
    apk)    sudo apk add "$@" ;;
  esac
}

# Latest release tag for a GitHub repo, without needing auth.
latest_tag() {
  curl -fsSL "https://api.github.com/repos/$1/releases/latest" | jq -r .tag_name
}

# Extract one binary from a GitHub release tarball into a destination dir.
#   install_release <repo> <asset-name> <path-in-tarball> <binary> <dest> [strip]
install_release() {
  local repo="$1" asset="$2" inner="$3" bin="$4" dest="$5" strip="${6:-1}" tmp
  tmp="$(mktemp -d)"
  curl -fsSL "https://github.com/$repo/releases/download/$asset" \
    | tar xz -C "$tmp" --strip-components="$strip"
  install -Dm755 "$tmp/$inner" "$dest/$bin"
  rm -rf "$tmp"
}

step_packages() {
  log "native packages via $PM"
  # canonical:binary — checking the binary keeps this manager-agnostic.
  local pairs=(
    fish:fish git-delta:delta ripgrep:rg lsd:lsd jq:jq
    keychain:keychain vim:vim curl:curl unzip:unzip
    fontconfig:fc-cache toolchain:cc
  )
  local wanted=()
  for pair in "${pairs[@]}"; do
    have "${pair#*:}" || wanted+=("$(pkg_name "${pair%%:*}")")
  done
  if [[ ${#wanted[@]} -eq 0 ]]; then
    skip "all native packages"
    return
  fi
  log "installing: ${wanted[*]}"
  pm_install "${wanted[@]}"
}

step_localbin() {
  log "upstream releases -> $LOCAL_BIN"
  # From upstream rather than the distro: Debian/Ubuntu ship these as
  # batcat/fdfind, and the configs in this repo expect the upstream names.
  local tag
  for repo_name in sharkdp/bat:bat sharkdp/fd:fd; do
    local repo="${repo_name%%:*}" name="${repo_name#*:}"
    if have "$name"; then skip "$name"; continue; fi
    tag="$(latest_tag "$repo")"
    install_release "$repo" \
      "$tag/$name-$tag-$RUST_TRIPLE.tar.gz" "$name" "$name" "$LOCAL_BIN"
    log "installed $name $tag"
  done

  if have gh; then
    skip gh
  else
    tag="$(latest_tag cli/cli)"
    install_release cli/cli \
      "$tag/gh_${tag#v}_linux_${GOARCH}.tar.gz" bin/gh gh "$LOCAL_BIN"
    log "installed gh $tag"
  fi
}

step_usrlocal() {
  log "starship + lazygit -> /usr/local/bin"
  if have starship; then
    skip starship
  else
    curl -fsSL https://starship.rs/install.sh | sh -s -- --yes
  fi

  if have lazygit; then
    skip lazygit
  else
    local tag tmp
    tag="$(latest_tag jesseduffield/lazygit)"
    tmp="$(mktemp -d)"
    curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/${tag}/lazygit_${tag#v}_Linux_${LAZYGIT_ARCH}.tar.gz" \
      | tar xz -C "$tmp"
    sudo install -m755 "$tmp/lazygit" /usr/local/bin/lazygit
    rm -rf "$tmp"
  fi
}

step_fzf() {
  log "fzf -> ~/.fzf"
  if [[ -d "$HOME/.fzf" ]]; then
    git -C "$HOME/.fzf" pull --ff-only
  else
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  fi
  # config.fish handles fish integration via `fzf --fish`.
  "$HOME/.fzf/install" --bin --no-bash --no-zsh --no-fish
}

step_rust() {
  log "rust toolchain"
  if have cargo; then
    skip cargo
  else
    curl -fsSL https://sh.rustup.rs | sh -s -- -y --no-modify-path
  fi
}

step_cargo() {
  log "cargo tools"
  # shellcheck source=/dev/null
  [[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
  have cargo || { echo "cargo missing; run the 'rust' step first." >&2; return 1; }

  have zellij || cargo install --locked zellij
  have stylua || cargo install stylua
  have bob    || cargo install bob-nvim
  if have yazi; then skip yazi; else cargo install --locked yazi-fm yazi-cli; fi
}

step_neovim() {
  log "neovim via bob"
  have bob || { echo "bob missing; run the 'cargo' step first." >&2; return 1; }
  bob install stable
  bob use stable
}

step_kitty() {
  log "kitty -> ~/.local/kitty.app"
  if [[ -d "$HOME/.local/kitty.app" ]]; then
    skip kitty
    return
  fi
  curl -fsSL https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  mkdir -p "$LOCAL_BIN" "$HOME/.local/share/applications"
  ln -sf "$HOME/.local/kitty.app/bin/kitty" "$LOCAL_BIN/kitty"
}

step_asdf() {
  log "asdf + plugins"
  if have asdf; then
    skip asdf
  else
    local tag
    tag="$(latest_tag asdf-vm/asdf)"
    mkdir -p "$HOME/.asdf/bin"
    curl -fsSL "https://github.com/asdf-vm/asdf/releases/download/${tag}/asdf-${tag}-linux-${GOARCH}.tar.gz" \
      | tar xz -C "$HOME/.asdf/bin"
  fi
  export PATH="$HOME/.asdf/bin:$PATH"
  asdf plugin list 2>/dev/null | grep -qx nodejs     || asdf plugin add nodejs
  asdf plugin list 2>/dev/null | grep -qx lazydocker || asdf plugin add lazydocker
}

step_pnpm() {
  log "pnpm"
  # config.fish exports PNPM_HOME and expects pnpm to live there.
  if have pnpm; then skip pnpm; else curl -fsSL https://get.pnpm.io/install.sh | sh -; fi
}

step_fonts() {
  log "JetBrainsMono Nerd Font"
  local dir="$HOME/.local/share/fonts"
  if compgen -G "$dir/JetBrainsMono*" >/dev/null; then
    skip "JetBrainsMono Nerd Font"
    return
  fi
  mkdir -p "$dir"
  curl -fsSLo /tmp/JetBrainsMono.zip \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip -oq /tmp/JetBrainsMono.zip -d "$dir"
  rm -f /tmp/JetBrainsMono.zip
  if have fc-cache; then fc-cache -f; fi
}

step_vimplug() {
  log "vim-plug (for the .vimrc fallback)"
  local target="$HOME/.vim/autoload/plug.vim"
  if [[ -f "$target" ]]; then
    skip vim-plug
    return
  fi
  curl -fsSLo "$target" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

step_shell() {
  log "default shell"
  if [[ "${SHELL:-}" == *fish ]]; then
    skip "fish as login shell"
    return
  fi
  local fish_path
  fish_path="$(command -v fish)" || { warn "fish not installed; run 'packages' first"; return; }
  grep -qxF "$fish_path" /etc/shells || echo "$fish_path" | sudo tee -a /etc/shells >/dev/null
  chsh -s "$fish_path"
  echo "    log out and back in for the shell change to apply"
}

readonly STEPS=(packages localbin usrlocal fzf rust cargo neovim kitty asdf pnpm fonts vimplug shell)

main() {
  if [[ "${1:-}" == "--list" ]]; then
    printf '%s\n' "${STEPS[@]}"
    return 0
  fi

  detect_arch
  detect_pm
  log "$(uname -m) / $PM"

  local selected=("${STEPS[@]}")
  [[ $# -gt 0 ]] && selected=("$@")

  for s in "${selected[@]}"; do
    if ! declare -F "step_$s" >/dev/null; then
      echo "Unknown step: $s (see --list)" >&2
      exit 1
    fi
    "step_$s"
  done

  log "done. Remaining manual steps:"
  cat <<'EOF'
      - ~/.gitconfig.local  : work identities / private credential helpers
      - keyboard (X11)      : see the Keyboard section in README
      - :PlugInstall        : inside vim, if you use the .vimrc fallback
EOF
}

main "$@"

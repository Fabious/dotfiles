#!/usr/bin/env bash
# Sets up a fresh Linux Mint machine: Chrome, kitty, the font, zellij, fish, then
# checks out these dotfiles into $HOME. Every step skips work that is already
# done, so re-running it is safe.
#
#   curl -fsSLo /tmp/install.sh https://raw.githubusercontent.com/Fabious/dotfiles/master/install.sh
#   bash /tmp/install.sh

set -euo pipefail

readonly REPO=Fabious/dotfiles
readonly DOTFILES="$HOME/.dotfiles"

have()     { command -v "$1" >/dev/null 2>&1; }
log()      { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
dotfiles() { git --git-dir="$DOTFILES" --work-tree="$HOME" "$@"; }

log "apt packages"
sudo apt-get update
# git-delta: .gitconfig uses delta as the pager, so git breaks without it.
# build-essential: cargo needs a C linker to build bob.
sudo apt-get install -y curl git unzip fontconfig git-delta build-essential

log "Chrome"
if ! have google-chrome; then
  # The .deb also adds Google's apt repo, so Chrome updates with the system.
  curl -fsSLo /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt-get install -y /tmp/chrome.deb
  rm /tmp/chrome.deb
fi

log "kitty"
if [[ ! -x "$HOME/.local/kitty.app/bin/kitty" ]]; then
  curl -fsSL https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
fi
mkdir -p "$HOME/.local/bin" "$HOME/.local/share/applications"
ln -sf "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/kitty.app/bin/kitten" "$HOME/.local/bin/"
cp "$HOME/.local/kitty.app/share/applications/"kitty*.desktop "$HOME/.local/share/applications/"
sed -i \
  -e "s|Icon=kitty|Icon=$HOME/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" \
  -e "s|Exec=kitty|Exec=$HOME/.local/kitty.app/bin/kitty|g" \
  "$HOME/.local/share/applications/"kitty*.desktop

log "JetBrainsMono Nerd Font"
if [[ -z "$(fc-list 'JetBrainsMono Nerd Font')" ]]; then
  mkdir -p "$HOME/.local/share/fonts/JetBrainsMono"
  curl -fsSLo /tmp/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip -oq /tmp/JetBrainsMono.zip -d "$HOME/.local/share/fonts/JetBrainsMono"
  rm /tmp/JetBrainsMono.zip
  fc-cache -f
fi

log "zellij"
# Not in Mint's apt repos; the static musl build runs anywhere.
if [[ ! -x "$HOME/.local/bin/zellij" ]]; then
  curl -fsSL https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz \
    | tar xz -C "$HOME/.local/bin" zellij
fi

log "fish"
if ! ls /etc/apt/sources.list.d/ | grep -q fish-shell-release-4; then
  sudo add-apt-repository -y ppa:fish-shell/release-4
  sudo apt-get update
fi
sudo apt-get install -y fish
if [[ "$(getent passwd "$USER" | cut -d: -f7)" != /usr/bin/fish ]]; then
  chsh -s /usr/bin/fish
fi

log "dotfiles"
if [[ ! -d "$DOTFILES" ]]; then
  # https because a fresh machine has no SSH key on GitHub yet; push over ssh.
  git clone --bare "https://github.com/$REPO.git" "$DOTFILES"
  dotfiles remote set-url origin "git@github.com:$REPO.git"
fi
# Not optional: the work-tree is $HOME, so untracked files would mean all of it.
dotfiles config --local status.showUntrackedFiles no
if ! dotfiles checkout 2>/dev/null; then
  backup="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
  log "moving existing files to $backup"
  dotfiles ls-tree -r --name-only HEAD | while read -r f; do
    if [[ -e "$HOME/$f" ]]; then
      mkdir -p "$backup/$(dirname "$f")"
      mv "$HOME/$f" "$backup/$f"
    fi
  done
  dotfiles checkout
fi

# After the checkout: bob reads ~/.config/bob/config.json from this repo, which
# stops it prompting to edit shell rc files. config.fish puts both on PATH.
log "cargo"
if [[ ! -x "$HOME/.cargo/bin/cargo" ]]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi

log "bob"
if [[ ! -x "$HOME/.cargo/bin/bob" ]]; then
  "$HOME/.cargo/bin/cargo" install bob-nvim
fi

log "neovim (latest stable, via bob)"
"$HOME/.cargo/bin/bob" use stable

log "done — log out and back in so fish becomes your login shell"

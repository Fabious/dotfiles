# PATH first, so everything below finds the tools. ~/.local/bin holds what
# install.sh downloads (zellij, starship, fzf, mise…); fish doesn't read
# ~/.profile, so don't rely on it adding ~/.local/bin. Then cargo, and bob's
# nvim proxy. fish_add_path skips dirs that don't exist.
fish_add_path -g ~/.local/bin ~/.cargo/bin ~/.local/share/bob/nvim-bin

# mise — runtime versions (node, python…), see README
type -q mise; and mise activate fish | source

. ~/.config/fish/aliases.fish

# Globals
set -gx EDITOR nvim

# Every tool below is optional: skip it when it isn't installed, so a fresh
# machine with only fish starts without errors.

# SSH
if type -q keychain
  eval (env SHELL=/usr/bin/fish keychain --eval --quiet id_ed25519 2>$HOME/ssh-keychain.log)
end

# Zellij — only in kitty windows. KITTY_WINDOW_ID isn't forwarded over ssh,
# unlike TERM=xterm-kitty, so remote shells don't nest a second zellij.
if status is-interactive; and set -q KITTY_WINDOW_ID; and type -q zellij; and not set -q ZELLIJ
  zellij --layout compact
end

# Install Starship prompt
# curl -sS https://starship.rs/install.sh | sh
# To update the Starship itself, rerun the above script.
# It will replace the current version without touching Starship's configuration.
type -q starship; and starship init fish | source

# Zoxide
type -q zoxide; and zoxide init fish | source

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# FZF
type -q fzf; and fzf --fish | source

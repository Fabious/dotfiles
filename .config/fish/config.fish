. ~/.config/fish/aliases.fish

# Globals
set -gx EDITOR nvim

# Every tool below is optional: skip it when it isn't installed, so a fresh
# machine with only fish starts without errors.

# SSH
if type -q keychain
  eval (env SHELL=/usr/bin/fish keychain --eval --quiet id_ed25519 2>$HOME/ssh-keychain.log)
end

# Zellij
if status is-interactive; and type -q zellij; and not set -q ZELLIJ
  zellij --layout compact
end

# Install Starship prompt
# curl -sS https://starship.rs/install.sh | sh
# To update the Starship itself, rerun the above script.
# It will replace the current version without touching Starship's configuration.
type -q starship; and starship init fish | source

# Zoxide
type -q zoxide; and zoxide init fish | source

# ASDF (0.16+ is a single Go binary; no asdf.fish to source)
if test -x ~/.asdf/bin/asdf
  fish_add_path -g ~/.asdf/bin
  set -q ASDF_DATA_DIR; or set -gx ASDF_DATA_DIR ~/.asdf
  fish_add_path -g $ASDF_DATA_DIR/shims
end

# pnpm
set -gx PNPM_HOME "/home/fabious/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# FZF
type -q fzf; and fzf --fish | source

. ~/.config/fish/aliases.fish

# Globals
set -gx EDITOR nvim

# SSH
eval (env SHELL=/usr/bin/fish keychain --eval --quiet id_ed25519 2>$HOME/ssh-keychain.log)

# Zellij
if set -q ZELLIJ
else
  zellij --layout compact
end

# Install Starship prompt
# curl -sS https://starship.rs/install.sh | sh
# To update the Starship itself, rerun the above script.
# It will replace the current version without touching Starship's configuration.
starship init fish | source

# Zoxide
zoxide init fish | source

# ASDF (0.16+ is a single Go binary; no asdf.fish to source)
if test -x ~/.asdf/bin/asdf
  fish_add_path -g ~/.asdf/bin
  set -q ASDF_DATA_DIR; or set -gx ASDF_DATA_DIR ~/.asdf
  fish_add_path -g $ASDF_DATA_DIR/shims
end

# Zellij
source ~/.config/fish/completions/zellij.fish

# pnpm
set -gx PNPM_HOME "/home/fabious/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# FZF
fzf --fish | source

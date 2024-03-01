. ~/.config/fish/aliases.fish

# Globals
set -gx EDITOR nvim

# Install Starship prompt
# curl -sS https://starship.rs/install.sh | sh
# To update the Starship itself, rerun the above script.
# It will replace the current version without touching Starship's configuration.
starship init fish | source

# Zoxide
zoxide init fish | source

# ASDF
source ~/.asdf/asdf.fish

# Zellij
source ~/.config/fish/completions/zellij.fish

# pnpm
set -gx PNPM_HOME "/home/fabious/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

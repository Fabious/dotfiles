. ~/.config/fish/aliases.fish

# Globals
set -gx EDITOR nvim

# SSH
eval (env SHELL=/usr/bin/fish keychain --eval --quiet --noask --agents ssh 2>$HOME/ssh-keychain.log)

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

# FZF
fzf --fish | source

# Lazygit — chain our config with the Tinty-generated theme (lazygit has no include mechanism)
set -gx LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml,$HOME/.local/share/tinted-theming/tinty/tinted-lazygit-themes-file.yml"

# Tinty — re-apply the current scheme to this shell session
if status is-interactive
  tinty init >/dev/null
end

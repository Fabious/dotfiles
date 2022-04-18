. ~/.config/fish/aliases.fish

# Globals
set -gx EDITOR nvim

#set fish_color_hostname 'a67523'
#set -gx fish_greeting ''

# iTerm shell integration
test -e ~/.iterm2_shell_integration.fish; and source ~/.iterm2_shell_integration.fish

# Install Starship prompt
# curl -sS https://starship.rs/install.sh | sh
# To update the Starship itself, rerun the above script.
# It will replace the current version without touching Starship's configuration.
starship init fish | source


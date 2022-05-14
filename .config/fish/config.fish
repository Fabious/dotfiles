. ~/.config/fish/aliases.fish

# Globals
set -gx EDITOR nvim

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end

# iTerm shell integration
test -e ~/.iterm2_shell_integration.fish; and source ~/.iterm2_shell_integration.fish

# Install Starship prompt
# curl -sS https://starship.rs/install.sh | sh
# To update the Starship itself, rerun the above script.
# It will replace the current version without touching Starship's configuration.
starship init fish | source

# asdf
source /opt/asdf-vm/asdf.fish

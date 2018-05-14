# dotfiles
My 1337 setup

## Install Fish Shell on Mac OS X and Ubuntu
```
brew install fish
```
Once installation has completed, add Fish to /etc/shells, which will require an administrative password:
```
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
```
To make Fish your default shell:
```
chsh -s /usr/local/bin/fish
```
The Fish shell should now be installed, but a bit more configuration will prove helpful later.
Create the Fish config directory:
```
mkdir -p ~/.config/fish
```
Create initial config file:
```
vim ~/.config/fish/config.fish
```
Initial config file contents, which adds /usr/local/bin to the PATH environment variable:
```
set -g -x PATH /usr/local/bin $PATH
```
Open a new terminal session, which should now load the Fish shell by default for the first time. You can enter help, followed by the return key, to load user documentation in your default browser.
You can also see your current configuration in your default browser by first entering this command:
```
fish_config
```
… and then visiting http://localhost:8000/ in your browser of choice.

Fish can parse your installed man pages and automatically generate completion files for your command-line tools. You should periodically run the following command to update those completions, which are stored in ~/.config/fish/completions by default:
```
fish_update_completions
```
Last but not least, running:
```
echo "set -g -x fish_greeting ''" >> ~/.config/fish/config.fish
```
… will eliminate the Fish welcome message that appears by default. If you want to add your own custom welcome message instead of removing the message entirely, insert your preferred text inside the '' marks.

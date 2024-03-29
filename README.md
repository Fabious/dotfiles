# dotfiles

My 1337 setup

## Installation

Before starting the installation, I recommend reading theses articles to understand how this repository was setup to use the power git --bare:

- https://www.atlassian.com/git/tutorials/dotfiles
- https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/
- https://engineeringwith.kalkayan.io/series/developer-experience/storing-dotfiles-with-git-this-is-the-way/

```
# To install the dotfiles
git clone --bare git@github.com:fabious/dotfiles.git ~/.dotfiles
/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME config --local status.showUntrackedFiles no
```

```
# Then use this alias to update the repo like you would normally do
alias dotfiles '/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# initial install of the dotfiles
dotfiles checkout

# normal git commands
dotfiles status
dotfiles add ~/.config/nvim/init.vim
dotfiles commit -m 'update neovim config'
dotfiles push
```

## Tools

- [fish][fish] - The user-friendly command line shell
- [starship][starship] - The minimal, blazing-fast, and infinitely customizable prompt
- [gh][gh] - GitHub’s official command line tool
- [delta][delta] - A syntax-highlighting pager for git, diff, and grep output
- [bat][bat] - A cat(1) clone with wings
- [fd][fd] - A simple, fast and user-friendly alternative to 'find'
- [ripgrep][ripgrep] - ripgrep recursively searches directories for a regex pattern
- [lsd][lsd] - The next gen ls command
- [exa][exa] - A modern replacement for ls
- [fzf][fzf] - 🌸 A command-line fuzzy finder
- [jq][jq] - Command-line JSON processor
- [procs][procs] - A modern replacement for ps written in Rust
- [lazydocker][lazydocker] - Docker TUI
- [lazygit][lazygit] - Simple terminal UI for git commands
- [tokei][tokei] - Count your code, quickly
- [glow][glow] - Render markdown on the CLI, with pizzazz! 💅🏻

## Arch

```
# Set keyboard repeat rate
xset r rate 220 40

# Set Caps Lock to Ctrl_modifier
setxkbmap -option caps:ctrl_modifier

# Set Compose key (eg: french accents)
setxkbmap -option compose:ralt

# To make it persitent in Xfce4, add this line :
# Option "XkbOptions" "caps:ctrl_modifier,compose:ralt"
sudo vim /etc/X11/xorg.conf.d/00-keyboard.conf
```

## ASDF

```
# Install asdf with yay (AUR helper)
yay -S asdf-vm

# Install nodejs
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf global nodejs latest

# Install Python
asdf plugin add python
asdf install python latest
asdf global python latest

# Check everything is fine
asdf current
```

## Fonts

I use the [Cascadia Code Nerd Font][cascadia-code-nerd-font].

```
# Install on Arch
yay -S nerd-fonts-cascadia-code
```

## Inspiration

- https://github.com/nvie/dotfiles
- https://github.com/gf3/dotfiles
- https://github.com/paulirish/dotfiles
- https://github.com/mathiasbynens/dotfiles/
- https://github.com/kalkayan/dotfiles

[bat]: https://github.com/sharkdp/bat
[delta]: https://github.com/dandavison/delta
[exa]: https://github.com/ogham/exa
[fd]: https://github.com/sharkdp/fd
[fish]: https://fishshell.com/
[fzf]: https://github.com/junegunn/fzf
[gh]: https://github.com/cli/cli
[glow]: https://github.com/charmbracelet/glow
[hack-font]: https://sourcefoundry.org/hack/
[cascadia-code-nerd-font]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode
[jq]: https://github.com/stedolan/jq
[lazydocker]: https://github.com/jesseduffield/lazydocker
[lazygit]: https://github.com/jesseduffield/lazygit
[lsd]: https://github.com/Peltoche/lsd
[procs]: https://github.com/dalance/procs
[ripgrep]: https://github.com/BurntSushi/ripgrep
[starship]: https://github.com/starship/starship
[tokei]: https://github.com/XAMPPRocky/tokei

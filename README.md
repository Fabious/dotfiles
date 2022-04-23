# dotfiles
My 1337 setup

## Installation

Before starting the installation, I recommend reading theses articles to understand how this repository was setup to use the power git --bare:

- https://www.atlassian.com/git/tutorials/dotfiles
- https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/
- https://engineeringwith.kalkayan.io/series/developer-experience/storing-dotfiles-with-git-this-is-the-way/

```
# To install the dotfiles
git clone --bare https://github.com/fabious/dotfiles.git ~/.dotfiles
/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME config --local status.showUntrackedFiles no
```

```
# Then use this alias to update the repo like you would normally do
# alias dotfiles '/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# initial install of the dotfiles
dotfiles checkout

# normal git commands
dotfiles status
dotfiles add ~/.config/nvim/init.vim
dotfiles commit -m 'update neovim config'
dotfiles push
```

## Tools

* [fish][fish] - The user-friendly command line shell
* [delta][delta] - A syntax-highlighting pager for git, diff, and grep output
* [bat][bat] - A cat(1) clone with wings
* [fd][fd] - A simple, fast and user-friendly alternative to 'find'
* [ripgrep][ripgrep] - ripgrep recursively searches directories for a regex pattern
* [lsd][lsd] - The next gen ls command
* [fzf][fzf] - 🌸 A command-line fuzzy finder
* [jq][jq] - Command-line JSON processor
* [lazygit][lazygit] - simple terminal UI for git commands
* [glow][glow] - Render markdown on the CLI, with pizzazz! 💅🏻

## Fonts

I use the [Cascadia Code Nerd Font][cascadia-nerd-font] which is the [Cascadia Code][cascadia-font] font
which has been patched with additional glyphs.

## Inspiration

* https://github.com/nvie/dotfiles
* https://github.com/gf3/dotfiles
* https://github.com/paulirish/dotfiles
* https://github.com/mathiasbynens/dotfiles/
* https://github.com/kalkayan/dotfiles

[bat]: https://github.com/sharkdp/bat
[fd]: https://github.com/sharkdp/fd
[fish]: https://fishshell.com/
[delta]: https://github.com/dandavison/delta
[fzf]: https://github.com/junegunn/fzf
[glow]: https://github.com/charmbracelet/glow
[cascadia-font]: https://github.com/microsoft/cascadia-code
[cascadia-nerd-font]: https://github.com/ryanoasis/nerd-fonts#patched-fonts
[jq]: https://github.com/stedolan/jq
[lazygit]: https://github.com/jesseduffield/lazygit
[lsd]: https://github.com/Peltoche/lsd
[ripgrep]: https://github.com/BurntSushi/ripgrep


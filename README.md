# dotfiles

My 1337 setup

## Installation

Before starting the installation, I recommend reading theses articles to understand how this repository was setup to use the power git --bare:

- https://www.atlassian.com/git/tutorials/dotfiles
- https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/
- https://engineeringwith.kalkayan.io/series/developer-experience/storing-dotfiles-with-git-this-is-the-way/

On a fresh Linux Mint machine:

```sh
curl -fsSLo /tmp/install.sh https://raw.githubusercontent.com/Fabious/dotfiles/master/install.sh
bash /tmp/install.sh
```

It installs Chrome, kitty, the JetBrainsMono Nerd Font, git-delta, zellij and fish
(set as the login shell), then checks out the dotfiles into `$HOME`. Files
already in the way are moved to `~/.dotfiles-backup/<date>/` first. Re-running
it is safe.

What it does for the dotfiles, by hand:

```sh
git clone --bare git@github.com:Fabious/dotfiles.git ~/.dotfiles
/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME config --local status.showUntrackedFiles no
/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
```

`status.showUntrackedFiles no` is not optional. The work-tree is `$HOME`, so
without it every command that walks untracked files enumerates the entire home
directory — `status --untracked-files=all` produces well over 100 MB of output.

```sh
# Then use this alias to update the repo like you would normally do
alias dotfiles '/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# normal git commands
dotfiles status
dotfiles add ~/.config/nvim/init.lua
dotfiles commit -m 'update neovim config'
dotfiles push
```

### What must never be committed

The remote is **public** and the work-tree is `$HOME`, which means a careless
`dotfiles add` can publish an SSH key or an auth token. Two layers guard against
that:

- **`.gitignore`** — tracked, so the rules follow the repo to a new machine.
  Covers `.ssh/`, `.gnupg/`, `.claude/.credentials.json`, prompt history,
  agent transcripts, and machine-local state.
- **`.dotfiles/info/exclude`** — local to one clone, never committed. Use it for
  anything machine-specific that should not be published as a rule for others.

Machine-local git config (work identities, credential helpers for private
GitLab/GitHub instances) belongs in `~/.gitconfig.local`, which `.gitconfig`
includes and `.gitignore` excludes.

## Machine

Developed on Linux Mint 22.1 (`xia`, Ubuntu 24.04 `noble` base).

## Tools

`install.sh` only sets up fish, kitty, zellij and git-delta from this list. The configs
cover the rest too; install them by hand when you need them. `config.fish`
skips any tool that isn't installed.

| Tool | What it is | Installed via |
| --- | --- | --- |
| [fish][fish] | The user-friendly command line shell | `install.sh` (fish 4 PPA) |
| [git-delta][delta] | A syntax-highlighting pager for git, diff, and grep output | `install.sh` (apt) |
| [ripgrep][ripgrep] | Recursively searches directories for a regex pattern | native package manager |
| [lsd][lsd] | The next gen ls command | native package manager |
| [jq][jq] | Command-line JSON processor | native package manager |
| [keychain][keychain] | Manages ssh-agent across logins | native package manager |
| [starship][starship] | The minimal, blazing-fast, infinitely customizable prompt | official script → `/usr/local/bin` |
| [lazygit][lazygit] | Simple terminal UI for git commands | GitHub release → `/usr/local/bin` |
| [gh][gh] | GitHub's official command line tool | GitHub release → `~/.local/bin` |
| [bat][bat] | A cat(1) clone with wings | GitHub release → `~/.local/bin` |
| [fd][fd] | A simple, fast and user-friendly alternative to 'find' | GitHub release → `~/.local/bin` |
| [fzf][fzf] | 🌸 A command-line fuzzy finder | git clone → `~/.fzf` |
| [kitty][kitty] | GPU-based terminal emulator | `install.sh` (official installer → `~/.local/kitty.app`) |
| [zellij][zellij] | Terminal workspace / multiplexer, auto-started in kitty | `install.sh` (GitHub release → `~/.local/bin`) |
| [yazi][yazi] | Blazing fast terminal file manager | `cargo install --locked yazi-fm yazi-cli` |
| [stylua][stylua] | Lua formatter (used by conform.nvim) | `cargo install stylua` |
| [bob][bob] | Neovim version manager | `cargo install bob-nvim` |
| [neovim][neovim] | Main editor | `bob install stable` |
| [lazydocker][lazydocker] | Docker TUI | asdf plugin |
| [asdf][asdf] | Multi-runtime version manager | GitHub release → `~/.asdf` |

`bat` and `fd` come from upstream releases rather than the distro package on
purpose: Debian/Ubuntu ship them as `batcat` and `fdfind` to avoid name
collisions, and the configs here expect the upstream names. On distros that do
not rename them this is redundant but harmless.

`.vimrc` is kept as a fallback for when `nvim` is unavailable. It needs
[vim-plug][vim-plug] at `~/.vim/autoload/plug.vim`, then `:PlugInstall`.

## Keyboard (X11)

```sh
# Set keyboard repeat rate
xset r rate 220 40

# Set Caps Lock to Ctrl_modifier
setxkbmap -option caps:ctrl_modifier

# Set Compose key (eg: french accents)
setxkbmap -option compose:ralt

# To make it persistent in Xfce4, add this line :
# Option "XkbOptions" "caps:ctrl_modifier,compose:ralt"
sudo vim /etc/X11/xorg.conf.d/00-keyboard.conf
```

## ASDF

```sh
# Install nodejs
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf set -u nodejs latest

# Install Python
asdf plugin add python
asdf install python latest
asdf set -u python latest

# Check everything is fine
asdf current
```

## Fonts

I use the [JetBrainsMono Nerd Font][jetbrainsmono-nerd-font], installed by
`install.sh` into `~/.local/share/fonts/JetBrainsMono`.

## Inspiration

- https://github.com/nvie/dotfiles
- https://github.com/gf3/dotfiles
- https://github.com/paulirish/dotfiles
- https://github.com/mathiasbynens/dotfiles/
- https://github.com/kalkayan/dotfiles

[asdf]: https://asdf-vm.com/
[bat]: https://github.com/sharkdp/bat
[bob]: https://github.com/MordechaiHadad/bob
[delta]: https://github.com/dandavison/delta
[fd]: https://github.com/sharkdp/fd
[fish]: https://fishshell.com/
[fzf]: https://github.com/junegunn/fzf
[gh]: https://github.com/cli/cli
[jq]: https://github.com/jqlang/jq
[keychain]: https://github.com/funtoo/keychain
[kitty]: https://sw.kovidgoyal.net/kitty/
[lazydocker]: https://github.com/jesseduffield/lazydocker
[lazygit]: https://github.com/jesseduffield/lazygit
[lsd]: https://github.com/lsd-rs/lsd
[neovim]: https://neovim.io/
[ripgrep]: https://github.com/BurntSushi/ripgrep
[starship]: https://github.com/starship/starship
[stylua]: https://github.com/JohnnyMorganz/StyLua
[vim-plug]: https://github.com/junegunn/vim-plug
[yazi]: https://github.com/sxyazi/yazi
[zellij]: https://github.com/zellij-org/zellij
[jetbrainsmono-nerd-font]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/JetBrainsMono

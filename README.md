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

It installs Chrome, Docker, kitty, the JetBrainsMono Nerd Font, the shell tools
(git-delta, ripgrep, zoxide, keychain, lsd, zellij, tree-sitter, starship, fzf,
mise) and fish (set as the login shell), then checks out the dotfiles into
`$HOME`, then installs cargo, bob, the latest stable Neovim and the mise tools
(Node, lazygit, lazydocker, gh, fd, bat). Files already in the way are moved to
`~/.dotfiles-backup/<date>/` first. Re-running it is safe.

### After the first run

1. Log out and back in: that makes fish the login shell and lets you run
   `docker` without `sudo`.
2. Sign in to GitHub: `gh auth login`.

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

## Updating

```sh
mise upgrade        # the mise tools (node, lazygit, gh, fd, bat…)
bob use stable      # Neovim, to the latest stable release
```

In Neovim, `:Lazy update` updates the plugins; then commit the new
`~/.config/nvim/lazy-lock.json`:

```sh
dotfiles commit -am 'nvim: update plugins' && dotfiles push
```

## Machine

Developed on Linux Mint 22.1 (`xia`, Ubuntu 24.04 `noble` base).

## Tools

Everything marked `install.sh` below is set up by the script. The configs cover the rest too; install them by hand
when you need them. `config.fish` skips any tool that isn't installed.

| Tool | What it is | Installed via |
| --- | --- | --- |
| [fish][fish] | The user-friendly command line shell | `install.sh` (fish 4 PPA) |
| [git-delta][delta] | A syntax-highlighting pager for git, diff, and grep output | `install.sh` (apt) |
| [ripgrep][ripgrep] | Recursively searches directories for a regex pattern (fzf-lua grep) | `install.sh` (apt) |
| [lsd][lsd] | The next gen ls command | `install.sh` (apt) |
| [jq][jq] | Command-line JSON processor | native package manager |
| [keychain][keychain] | Manages ssh-agent across logins | `install.sh` (apt) |
| [zoxide][zoxide] | A smarter cd command (`z`) | `install.sh` (apt) |
| [starship][starship] | The minimal, blazing-fast, infinitely customizable prompt | `install.sh` (official script → `~/.local/bin`) |
| [lazygit][lazygit] | Simple terminal UI for git commands (`lg`) | `install.sh` (mise) |
| [gh][gh] | GitHub's official command line tool | `install.sh` (mise) |
| [bat][bat] | A cat(1) clone with wings | `install.sh` (mise) |
| [fd][fd] | A simple, fast and user-friendly alternative to 'find' | `install.sh` (mise) |
| [fzf][fzf] | 🌸 A command-line fuzzy finder (also used by fzf-lua in Neovim) | `install.sh` (GitHub release → `~/.local/bin`) |
| [kitty][kitty] | GPU-based terminal emulator | `install.sh` (official installer → `~/.local/kitty.app`) |
| [zellij][zellij] | Terminal workspace / multiplexer, auto-started in kitty | `install.sh` (GitHub release → `~/.local/bin`) |
| [yazi][yazi] | Blazing fast terminal file manager | `cargo install --locked yazi-fm yazi-cli` |
| [stylua][stylua] | Lua formatter (used by conform.nvim) | `cargo install stylua` |
| [cargo][cargo] | Rust toolchain, used to build bob | `install.sh` (rustup) |
| [bob][bob] | Neovim version manager | `install.sh` (`cargo install bob-nvim`) |
| [neovim][neovim] | Main editor | `install.sh` (`bob use stable`) |
| [tree-sitter][tree-sitter] | CLI that nvim-treesitter uses to build parsers | `install.sh` (GitHub release → `~/.local/bin`) |
| [mise][mise] | Runtime version manager (node, python…), replaces asdf | `install.sh` (official script → `~/.local/bin`) |
| [docker][docker] | Containers, with `docker compose` (`dc`) | `install.sh` (apt `docker.io`, `docker-compose-v2`) |
| [lazydocker][lazydocker] | Docker TUI (`ld`) | `install.sh` (mise) |

`bat` and `fd` come from mise rather than apt on purpose: Debian/Ubuntu ship
them as `batcat` and `fdfind`, and the configs here expect the upstream names.

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

## mise

Global runtimes and tools are listed in `~/.config/mise/config.toml`, and
`install.sh` installs them with `mise install`: Node (Neovim's Mason installs
several language servers with npm), lazygit, lazydocker, gh, fd and bat.

```sh
# Add a tool to the list and install it
mise use -g python@latest
mise use -g yazi@latest

# Check everything is fine
mise ls
```

`mise use -g` writes to `~/.config/mise/config.toml`, so commit it afterwards.
`mise` also reads asdf's `.tool-versions` files in projects.

## Fonts

I use the [JetBrainsMono Nerd Font][jetbrainsmono-nerd-font], installed by
`install.sh` into `~/.local/share/fonts/JetBrainsMono`.

## Inspiration

- https://github.com/nvie/dotfiles
- https://github.com/gf3/dotfiles
- https://github.com/paulirish/dotfiles
- https://github.com/mathiasbynens/dotfiles/
- https://github.com/kalkayan/dotfiles

[bat]: https://github.com/sharkdp/bat
[bob]: https://github.com/MordechaiHadad/bob
[cargo]: https://rustup.rs/
[delta]: https://github.com/dandavison/delta
[docker]: https://docs.docker.com/engine/
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
[mise]: https://mise.jdx.dev/
[neovim]: https://neovim.io/
[ripgrep]: https://github.com/BurntSushi/ripgrep
[starship]: https://github.com/starship/starship
[stylua]: https://github.com/JohnnyMorganz/StyLua
[tree-sitter]: https://github.com/tree-sitter/tree-sitter
[vim-plug]: https://github.com/junegunn/vim-plug
[yazi]: https://github.com/sxyazi/yazi
[zellij]: https://github.com/zellij-org/zellij
[zoxide]: https://github.com/ajeetdsouza/zoxide
[jetbrainsmono-nerd-font]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/JetBrainsMono

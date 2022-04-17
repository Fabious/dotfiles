# dotfiles
My 1337 setup

## Using these dotfiles 

Before starting the installation, I recommend reading theses articles to understand how this repository was setup to use the power git --bare:

- https://www.atlassian.com/git/tutorials/dotfiles
- https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/
- https://engineeringwith.kalkayan.io/series/developer-experience/storing-dotfiles-with-git-this-is-the-way/

```
# To install the dotfiles
git clone --bare https://github.com/fabious/dotfiles.git
```

```
# Then use this alias to update the repo like you would normally do
# alias dotfiles '/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

dotfiles status
dotfiles add ~/.config/nvim/init.vim
dotfiles push
```


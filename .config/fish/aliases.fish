# Quick edits
alias ea 'v ~/.config/fish/aliases.fish'
alias ef 'v ~/.config/fish/config.fish'
alias ek 'v ~/.config/kitty/kitty.conf'
alias ev 'v ~/.config/nvim/init.vim'
alias eg 'v ~/.gitconfig'
alias et 'v ~/.tmux.conf'

# Shortcuts
alias v nvim
alias g git
alias c clear
alias l ls
alias ld lazydocker
alias lg lazygit
alias ls lsd
alias lt 'lsd --tree'

# Git
alias a 'git amend --allow-empty --no-verify'
alias gaa 'git add .'
alias gap 'git add -p'
alias gti git
alias gcm 'git commit --message'
alias gco 'git checkout'
alias gs 'git status -s'
alias gst 'git status'
alias gb 'git branch'
alias gbD 'git branch -d'
alias gd 'git diff'
alias gfa 'git fetch --all'
alias gl 'git pull'
alias gp 'git push'
alias gp 'git push --force'
alias grc 'git rebase --continue'
alias gstat 'git show HEAD --stat'
alias gw 'git switch'
alias nah 'git reset --hard && git clean -df'

# Docker
alias dc docker-compose

# Dotfiles
alias dotfiles '/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

function f
    git ls-tree -r --name-only HEAD
end

function veslint -d 'Opens all files in Vim with ESLint issues'
    edit ( eslint $argv | grep -Ee '^/' )
end

function vts -d 'Opens all files with TypeScript issues in Vim'
    edit ( tsc | grep -vEe '^\s' | cut -d'(' -f1 | sort -u )
end

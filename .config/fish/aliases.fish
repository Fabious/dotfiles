# Quick edits
alias ea 'vim ~/.config/fish/aliases.fish'
alias ef 'vim ~/.config/fish/config.fish'
alias ev 'vim ~/.config/nvim/init.vim'
alias eg 'vim ~/.gitconfig'
alias et 'vim ~/.tmux.conf'

# Shortcuts
alias v nvim
alias g git
alias c clear
alias l ls
alias ls lsd
alias lt 'lsd --tree'

# Git
alias a 'git amend --allow-empty --no-verify'
alias gaa 'git add .'
alias gti git
alias gco 'git checkout'
alias gs 'git status -s'
alias gst 'git status'
alias gb 'git branch'
alias gbD 'git branch -d'
alias gd 'git diff'
alias gfa 'git fetch --all'
alias gl 'git pull'
alias gp 'git push'
alias gw 'git switch'
alias nah 'git reset --hard && git clean -df'

# Docker
alias dc docker-compose

# edit all modified git files in vim
# alternative: git status --porcelain | awk '{print $2}'
function vm
  v $(git diff HEAD --name-only)
end

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

# Quick edits
alias ea 'nvim ~/.config/fish/aliases.fish'
alias ef 'nvim ~/.config/fish/config.fish'
alias ev 'nvim ~/.config/nvim/init.vim'
alias eg 'nvim ~/.gitconfig'
alias et 'nvim ~/.tmux.conf'

# Shortcuts
alias v 'nvim'
alias l ls
alias g git
alias c clear

# Git
alias gti git
alias a 'git amend --allow-empty --no-verify'
alias gs 'git status -s'
alias gs 'git diff'
alias gp 'git push'

function f
    git ls-tree -r --name-only HEAD
end

function veslint -d 'Opens all files in Vim with ESLint issues'
    edit ( eslint $argv | grep -Ee '^/' )
end

function vts -d 'Opens all files with TypeScript issues in Vim'
    edit ( tsc | grep -vEe '^\s' | cut -d'(' -f1 | sort -u )
end

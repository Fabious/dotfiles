# Quick edits
alias ea 'v ~/.config/fish/aliases.fish'
alias ef 'v ~/.config/fish/config.fish'
alias ek 'v ~/.config/kitty/kitty.conf'
alias ev 'v ~/.config/nvim/init.vim'
alias eg 'v ~/.gitconfig'
alias et 'v ~/.tmux.conf'

# Quick open
alias gvc 'v (git show HEAD --pretty="format:" --name-only)'

# Shortcuts
alias v nvim
alias g git
alias r ranger
alias c clear
alias l ls
alias ld lazydocker
alias lg lazygit
alias ls 'lsd --group-directories-first'
alias lt 'lsd --tree'

# Git
alias a 'git amend --allow-empty --no-verify'
alias gaa 'git add .'
alias gap 'git add -p'
alias gti git
alias gcb 'git branch | grep -v "^\*" | fzf --height=20% --reverse --info=inline | xargs git checkout'
alias gcm 'git commit --message'
alias gco 'git checkout'
alias gs 'git status -s'
alias gst 'git status'
alias gb 'git branch'
alias gbD 'git branch -D'
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

function gwi -d 'git switch fzf'
  git switch (git branch -vv --color=always | grep -v '/HEAD\s' |
    fzf --height 40% --ansi --multi --tac | sed 's/^..//' | awk '{print $1}' |
    sed 's#^remotes/[^/]*/##')
end

function vs -d 'Opens all git staged files in Vim'
    v (git diff --name-only)
end

function vc -d 'Opens all files from last commit in Vim'
    v (git show --oneline --name-only --format='')
end

function veslint -d 'Opens all files in Vim with ESLint issues'
    v ( eslint $argv | grep -Ee '^/' )
end

function vts -d 'Opens all files with TypeScript issues in Vim'
    v ( tsc | grep -vEe '^\s' | cut -d'(' -f1 | sort -u )
end

# Ctrl + T
# 2>/dev/null removes the Send job X, “PROGRAM” to foreground message, omit that if you wish to keep it.
# commandline -f repaint tells fish to redraw the prompt to avoid weird cursor position issues.
function fish_user_key_bindings
    bind \ct 'fg 2>/dev/null; commandline -f repaint'
end


if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

. ~/.profile
. ~/.bashrc
[[ -s ~/.bash_config ]] && source ~/.bash_config

export PATH="$HOME/.cargo/bin:$PATH"

alias h='cd'
alias g='git'
alias gs='git status'
alias gsu='git status -u'
alias gcm='git checkout master'
alias gcmp='git checkout master && git pull'
alias gcl='git checkout -'
alias gfix='git commit --fixup'
alias gri='git rebase -i'
alias grc='git --no-pager diff --check --cached && git rebase --continue'
alias grinas='git rebase -i --no-autosquash'
alias gbit='$(createBackupBranch)'
alias gbn='goToBackupOriginalBranch'
alias lsd='ls -ld .[^.]*?'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias gc='gitBranchCopyName'
alias log-report='logGitReport'
alias lgrep='lsGrep'
alias ps-on-port='psOnPort'
alias wip='git add -A && git commit -m "wip"'
alias gap='git add -p'
alias rad='sudo killall coreaudiod'
alias gro='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'
alias dc='docker-compose'

PS1="> \[\e[1;37m\]\W\[\e[0m\] "

# Disable history expansion
set +H

export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR=vim
export LC_ALL=en_US.UTF-8

export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),ctrl-p:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-e:preview-down,ctrl-y:preview-up'"
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob !.git'

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

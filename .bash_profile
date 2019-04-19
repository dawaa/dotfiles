[[ -s ~/.bashrc ]] && source ~/.bashrc
[[ -s ~/.bash_config ]] && source ~/.bash_config

alias h='cd'
alias g='git'
alias gs='git status'
alias gcm='git checkout master'
alias gcl='git checkout -'
alias gfix='git commit --fixup'
alias gbk='' # @TODO create script to create backup branches
alias gri='git rebase -i'
alias grinas='git rebase -i --no-autosquash'
alias ganc='findRootSha'
alias gancm='findRootSha master'
alias gbit='$(createBackupBranch)'
alias gbn='goToBackupOriginalBranch'
alias htdocs='cd /Applications/MAMP/htdocs'
alias mamp='cd /Applications/MAMP'
alias lsd='ls -ld .[^.]*?'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias gc='gitBranchCopyName'
alias log-report='logGitReport'
alias lgrep='lsGrep'
alias ps-on-port='psOnPort'
alias wip='git add . && git commit -m "wip"'
alias gap='git add -p'
alias rad='sudo killall coreaudiod'
alias sauce='source ~/.bash_profile'
# alias skype='open -na /Applications/Skype.app --args -DataPath /Users/$(whoami)/Library/Application\ Support/Skype2'

# Override OSX vim, even when future updates occur
alias vi=/usr/local/bin/vim
alias vim=/usr/local/bin/vim

PS1="[\u] \[\e[1;37m\]\W\[\e[0m\] "

# Disable history expansion
set +H

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH=~/.composer/vendor/bin:$PATH
export PHP_AUTOCONF=/usr/local/bin/autoconf
export EDITOR=vim

# To activate nodenv upon each new shell instantiation
eval "$(nodenv init -)"

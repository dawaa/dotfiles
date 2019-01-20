[[ -s ~/.bashrc ]] && source ~/.bashrc
[[ -s ~/.bash_config ]] && source ~/.bash_config

export MAMP_SQL=/Applications/MAMP/Library/bin
export MAMP_PHP=/Applications/MAMP/bin/php/php7.1.1/bin
export PATH=~/.composer/vendor/bin:$PATH

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
alias rad='sudo killall coreaudiod'
# alias skype='open -na /Applications/Skype.app --args -DataPath /Users/$(whoami)/Library/Application\ Support/Skype2'

# Override OSX vim, even when future updates occur
alias vi=/usr/local/bin/vim
alias vim=/usr/local/bin/vim

PS1="[\u] \[\e[1;37m\]\W\[\e[0m\] "

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="$PATH:$MAMP_SQL:$MAMP_PHP"
export PHP_AUTOCONF=/usr/local/bin/autoconf
export EDITOR=vim

# To activate nodenv upon each new shell instantiation
eval "$(nodenv init -)"

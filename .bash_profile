[[ -s ~/.bashrc ]] && source ~/.bashrc

export MAMP_SQL=/Applications/MAMP/Library/bin
export MAMP_PHP=/Applications/MAMP/bin/php/php7.1.1/bin
export PATH=~/.composer/vendor/bin:$PATH

alias h='cd'
alias htdocs='cd /Applications/MAMP/htdocs'
alias mamp='cd /Applications/MAMP'
alias lsd='ls -ld .*?'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias gc='gitBranchCopyName'
alias log-report='logGitReport'
alias lgrep='lsGrep'
# alias skype='open -na /Applications/Skype.app --args -DataPath /Users/$(whoami)/Library/Application\ Support/Skype2'

PS1="[\u] \[\e[1;37m\]\W\[\e[0m\] "

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="$PATH:$MAMP_SQL:$MAMP_PHP"
export PHP_AUTOCONF=/usr/local/bin/autoconf

[[ -s ~/.bashrc ]] && source ~/.bashrc

export MAMP_SQL=/Applications/MAMP/Library/bin
#export MAMP_PHP=/Applications/MAMP/bin/php/php5.6.10/bin
# export MAMP_PHP=/Applications/MAMP/bin/php/php7.0.0/bin
export MAMP_PHP=/Applications/MAMP/bin/php/php7.1.1/bin
export PATH=~/.composer/vendor/bin:$PATH

ALLERMEDIA_PATH='allermedia-dev-environment'

alias amp="cd /Applications/MAMP/htdocs/$ALLERMEDIA_PATH/wp-content/plugins"
alias amt="cd /Applications/MAMP/htdocs/$ALLERMEDIA_PATH/wp-content/themes"
alias h='cd'
alias htdocs='cd /Applications/MAMP/htdocs'
alias mamp='cd /Applications/MAMP'
alias lsd='ls -ld .*?'
alias cl='clear'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias gc='gitBranchCopyName'
alias log-report='logGitReport'
alias lgrep='lsGrep'
#alias servers.start='sudo nginx && php-fpm --fpm-config /usr/local/etc/php/7.0/php-fpm.conf -D && mysql.server start'
alias servers.start='sudo nginx && php-fpm --fpm-config /usr/local/etc/php/7.0/php-fpm.conf -D && mysql.server start'
alias servers.stop='sudo bash -c "killall -9 php-fpm && mysql.server stop && sudo nginx -s stop"'
alias servers.rs='servers.stop && servers.start'
alias servers.ls='ps aux | grep nginx && ps aux | grep php-fpm && ps aux | grep mysql'
alias servers.mysql='mysql -S /tmp/mysql.sock -uroot'
alias nginx='cd /usr/local/etc/nginx/'
alias .php='cd /usr/local/etc/php/'
alias www='cd /usr/local/var/www/'
alias skype='open -na /Applications/Skype.app --args -DataPath /Users/$(whoami)/Library/Application\ Support/Skype2'

PS1="[\u] \[\e[1;37m\]\W\[\e[0m\] "

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="$PATH:$MAMP_SQL:$MAMP_PHP"
export PHP_AUTOCONF=/usr/local/bin/autoconf

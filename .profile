if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

[[ -s ~/.bashrc ]] && source ~/.bashrc
[[ -s ~/.bash_config ]] && source ~/.bash_config

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export NVM_DIR="$HOME/.nvm"

export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR=vim
export LC_ALL=en_US.UTF-8

eval "$(/opt/homebrew/bin/brew shellenv)"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

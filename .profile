if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

[ -s ~/.bashrc ] && source ~/.bashrc
[ -s ~/.bash_config ] && source ~/.bash_config

platform=$(determine_platform)

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export NVM_DIR="$HOME/.nvm"

export EDITOR=vim
export LC_ALL=en_US.UTF-8

export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),ctrl-p:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-e:preview-down,ctrl-y:preview-up'"
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob !.git'

[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ "$platform" = "OSX" ]; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
    eval "$(/opt/homebrew/bin/brew shellenv)"
    test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
fi

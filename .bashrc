source ~/git-completion.bash

gitBranchCopyName() {
    branchname="$1";

    git branch | grep $branchname | sed 's/ //g' | pbcopy
    git checkout `pbpaste`
}
export -f gitBranchCopyName

lsGrep() {
    find="$1"

    ls -l | grep $1
}
export -f lsGrep

logGitReport() {
    date="$1"

    git log --date=short --since=$date --graph --pretty=format:'%Cred%h%Creset [%ad] -%C(yellow)%d%Creset %s' --abbrev-commit
}
export -f logGitReport

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1"  ] && [ -s $BASE16_SHELL/profile_helper.sh  ] && eval "$($BASE16_SHELL/profile_helper.sh)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g ""'

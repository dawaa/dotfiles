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

is_in_git_repo() {
    git rev-parse HEAD > /dev/null 2>&1
}

fzfGitFiles() {
    is_in_git_repo &&
        git -c color.status=always status --short |
        fzf -m --ansi --nth 2..,.. |
        awk '{print $2}'
}
export -f fzfGitFiles

fzfGitBranches() {
    is_in_git_repo &&
        git branch -a -vv --color=always |
        grep -v '/HEAD\s' |
        fzf --ansi --multi --tac |
        sed 's/^..//' |
        awk '{print $1}' |
        sed 's#^remotes/[^/]*/##'
}
export -f fzfGitBranches


bind '"\C-g\C-f": "$(fzfGitFiles)\e\C-e"'
bind '"\C-g\C-g": "$(fzfGitBranches)\e\C-e"'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1"  ] && [ -s $BASE16_SHELL/profile_helper.sh  ] && eval "$($BASE16_SHELL/profile_helper.sh)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore node_modules -f -g ""'

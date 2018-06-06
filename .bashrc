# source ~/git-completion.bash

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

__fzf_history () {
    __ehc $(history | fzf --tac --tiebreak=index | perl -ne 'm/^\s*([0-9]+)/ and print "!$1"')
}

__ehc() {
    if
        [[ -n $1 ]]
    then
        bind '"\er": redraw-current-line'
        bind '"\e^": magic-space'
        READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${1}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
        READLINE_POINT=$(( READLINE_POINT + ${#1} ))
    else
        bind '"\er":'
        bind '"\e^":'
    fi
}

fzfDockerContainers() {
    docker ps -a --format '[{{.Status}}]\t\t{{.Names}}' | \
        sed 's#\[Created\]#CREATED#' | \
        sed 's#\[Exited.*\]#EXITED#' | \
        sed 's#\[Up.*\]#RUNNING#' | \
        column -t | \
        fzf -m | \
        awk '{print $2}'
}
export -f fzfDockerContainers

fzfDockerImages() {
    docker images --format '{{.Tag}}\t{{.Repository}}\t{{.ID}}' | \
        column -t | \
        fzf -m | \
        awk '{print $3}'
}
export -f fzfDockerImages

# [ -n "$BASH" ] && complete -F fzfDockerContainers -o default -o bashdefault doge

# re-wrote the script above
bind '"\C-r": "\C-x1\e^\er"'
bind -x '"\C-x1": __fzf_history';

bind '"\C-g\C-f": "$(fzfGitFiles)\e\C-e"'
bind '"\C-g\C-g": "$(fzfGitBranches)\e\C-e"'
bind '"\C-g\C-d": "$(fzfDockerContainers)\e\C-e"'
bind '"\C-g\C-i": "$(fzfDockerImages)\e\C-e"'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1"  ] && [ -s $BASE16_SHELL/profile_helper.sh  ] && eval "$($BASE16_SHELL/profile_helper.sh)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore node_modules -f -g ""'

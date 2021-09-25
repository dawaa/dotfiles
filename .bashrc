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
        git -c color.status=always status --short -u |
        sort -d |
        fzf -m --ansi --nth 2..,.. --preview='(echo {} | sed "s/^ *//;s/$//" | cut -d" " -f2) | xargs -I {} bat --style=numbers,changes --color=always {}' | awk '{print $2}'
}
export -f fzfGitFiles

fzfGitBranches() {
    is_in_git_repo &&
        git branch -a -vv --color=always --sort=committerdate |
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

gh() {
    is_in_git_repo || return
    git log \
        --date=short \
        --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" \
        --graph \
        --color=always |
        fzf-down \
        --ansi \
        --no-sort \
        --reverse \
        --multi \
        --bind 'ctrl-s:toggle-sort' \
        --bind 'ctrl-e:preview-down' \
        --bind 'ctrl-y:preview-up' \
        --header 'Press CTRL-S to toggle sort' \
        --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
        grep -o "[a-f0-9]\{7,\}"
}

fzf-down() {
  fzf --height 60% "$@" --border
}

psOnPort() {
    lsof -i tcp:$1
}

killOnPort() {
    num_processes=$(lsof -ti tcp:$1 | wc -l | sed 's/ //g')

    if [ "$num_processes" -eq 0 ]; then
        echo "Nothing running on port: $1"
    elif [ "$num_processes" -gt 0 ]; then
        lsof -ti tcp:$1 | xargs kill -9
        echo "Killed $num_processes process(es)"
    fi

}

findRootSha() {
    branch=$1
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    starting_point_sha=$(git merge-base $1 $current_branch)
    echo $starting_point_sha
}

createBackupBranch() {
    current_branch=$(git branch --show-current)
    is_backup_branch=$(echo "$current_branch" | grep -oc "_backup-[0-9]\+$")
    have_backup_branches=$(git branch | grep -c "${current_branch}_backup")

if [[ $is_backup_branch == 1 ]] || [[ $have_backup_branches -gt 0 ]]; then
    if [[ "$current_branch" =~ (.*)_backup-[0-9]+$ ]]; then
            orig_branch_name=${BASH_REMATCH[1]}
        elif [[ $have_backup_branches -gt 0 ]]; then
            orig_branch_name=$current_branch
        else
            echo "Couldn't create backup branch from: $current_branch"
        fi

        latest_backup_no=$(
            git branch \
                | grep "${orig_branch_name}_backup" \
                | grep -o "[0-9]\+" \
                | sort -n -r \
                | head -n1
        )


        if [[ "$latest_backup_no" =~ ^([0-9]+)$ ]]; then
            latest_no=${BASH_REMATCH[1]}
            bump=$(($latest_no + 1))
            git checkout -b ${orig_branch_name}_backup-${bump}
        else
            echo "Couldn't get latest backup no from: $current_branch "
        fi
    else
        git checkout -b ${current_branch}_backup-1
    fi
}

fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

goToBackupOriginalBranch() {
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    is_backup_branch=$(echo "$current_branch" | grep -oc "_backup-[0-9]\+$")

    if [[ $is_backup_branch == 1 ]]; then
        if [[ "$current_branch" =~ (.*)_backup-[0-9]+$ ]]; then
            orig_branch_name=${BASH_REMATCH[1]}
            git checkout $orig_branch_name
        fi
    else
        echo "You're not on a backup branch, goofball."
    fi
}

cs() {
    if [ "$BASE16_SHELL" ]; then
        eval $(ls $BASE16_SHELL/scripts | sed 's/\..*$//g' | sed 's/-/_/' | fzf --no-multi --header "current: $BASE16_THEME")
    else
        echo "You seem to be missing the ENV variable \$BASE16_SHELL."
    fi
}

# [ -n "$BASH" ] && complete -F fzfDockerContainers -o default -o bashdefault doge

# re-wrote the script above
bind '"\C-r": "\C-x1\e^\er"'
bind -x '"\C-x1": __fzf_history';

bind '"\er": redraw-current-line'
bind '"\C-g\C-f": "$(fzfGitFiles)\e\C-e\er"'
bind '"\C-g\C-g": "$(fzfGitBranches)\e\C-e\er"'
bind '"\C-g\C-d": "$(fzfDockerContainers)\e\C-e\er"'
bind '"\C-g\C-i": "$(fzfDockerImages)\e\C-e\er"'
bind '"\C-g\C-h": "$(gh)\e\C-e\er"'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

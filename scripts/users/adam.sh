#!/bin/bash

# An alias for changing the git user on this computer
alias git_adam='git config --global user.name AdamPettinger ; git config --global user.email adam.pettinger@utexas.edu'

#
#    Git
#

# Git command shortcuts
alias gs='git status'
alias gb='git branch -a -v'
gd() {
    git diff  --color-moved $@
}

# git log, pretty format. No arg defaults to 10 entries, arg less than 1 prints all entries, anything else prints the number given
gl() {
    if [ -z "$1" ]
    then
        git log -n 10 --graph --date=relative --pretty=format:'%C(yellow)commit %h %C(bold blue)%<(15,trunc)%an %Cgreen%<(13,trunc)%cd%Cred%d %n%C(yellow)  %m%Creset %s'
    elif [ "$1" -lt 1 ]
    then
        git log --graph --date=relative --pretty=format:'%C(yellow)commit %h %C(bold blue)%<(15,trunc)%an %Cgreen%<(13,trunc)%cd%Cred%d %n%C(yellow)  %m%Creset %s'
    else
        git log -n "$1" --graph --date=relative --pretty=format:'%C(yellow)commit %h %C(bold blue)%<(15,trunc)%an %Cgreen%<(13,trunc)%cd%Cred%d %n%C(yellow)  %m%Creset %s'
    fi
}

# For updating submodules recursively
alias gsub='git submodule update --init --recursive'

# View git remotes
alias grv='git remote -v'

# Fetch and pull a PR
# git_pull_pr(remote, pull-ID, branchname)
git_pull_pr() {
    git fetch $1 pull/$2/head:$3 && git checkout $3
}

# Cache git user credentials for 15 minutes or N seconds
git_cache() {
    if [ -z "$1" ] || [ "$1" -lt 1 ]
    then
        git config --global credential.helper cache
    else
        git config --global credential.helper 'cache --timeout '$1''
    fi
}

#
#    Catkin
#
# Build with half the computer cores and a list of args for package name
# No args = full catkin build
cb() {
    catkin build  -j $((($(nproc) + 1)/ 2)) $@
}

# Build with all cores but 1 and a list of args for package name
# No args = full catkin build
cbf() {
    catkin build  -j $(($(nproc) - 1)) $@
}

# Catkin clean without prompting for confirmation
cc() {
    catkin clean --yes $@
}

#
#    Navigation
#
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'

#
#    ROS Stuff
#
# Search for a package's use. Don't include from its own directory, and only include likely file types
pack_use() {
    grep -r --include=\*.{cpp,hpp,h,txt,xml,launch,yaml,py,pyc,rviz,md,sh,xacro,urdf} --exclude-dir="$1" "$1"
}

alias killros='killall -9 roscore ; killall -9 rosmaster'

#
#   C++ Formatting
#
# Clang format recursivly in the current directory, targetting h, hpp, and cpp files
alias clang_cpp='find . -name '*.h' -or -name '*.hpp' -or -name '*.cpp' -o -name '*.c' -o -name '*.cc' -o -name '*.proto' | xargs clang-format-10 -i -style=file'

#
#   File navigation and formatting
#
# In a folder, recursively find and replace text
replace(){
    grep -lr -e $1 * | xargs sed -i "s/$1/$2/g" ;
}

alias source_aliases='source ~/.bashrc ; source ~/.bash_aliases ; source $ALIASES_DIR/scripts/users/adam.sh'
alias edit_bashrc='code ~/.bashrc'
alias edit_bash_aliases='code ~/.bash_aliases'
alias edit_adam_aliases='code $ALIASES_DIR/scripts/users/adam.sh'

# Searching
function gr {
    grep -r -I --color=always $1
}
function cgr {
    clear ; gr $1
}
function gri {
    grep -ri -I --color=always $1
}
function cgri {
    clear ; gri $1
}

# Take and put files into temporary directory
function clear_adam_temp {
    if [ -z "$1" ]; then
        rm $ALIASES_DIR/.adam_aliases/adam/*
    else
        rm $ALIASES_DIR/.adam_aliases/adam/$1
    fi
}

function put {
    if [ -z "$1" ]; then
        exit -1
    else
        mv $1 $ALIASES_DIR/.adam_aliases/adam/
    fi
}
function putcopy {
    if [ -z "$1" ]; then
        exit -1
    else
        cp $1 $ALIASES_DIR/.adam_aliases/adam/
    fi
}
function take {
    if [ -z "$1" ]; then
        exit -1
    else
        cp $ALIASES_DIR/.adam_aliases/adam/$1 .
    fi
}
_temp_dir_completions()
{
    if [ "${#COMP_WORDS[@]}" != "2" ]; then
        return
    fi

    COMPREPLY=($(compgen -W "$(ls $ALIASES_DIR/.adam_aliases/adam/ | sed 's/\t//')" -- "${COMP_WORDS[1]}"))
}
complete -F _temp_dir_completions take
complete -F _temp_dir_completions clear_adam_temp

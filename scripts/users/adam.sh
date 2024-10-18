#!/bin/bash

# An alias for changing the git user on this computer
alias git_adam='git config --global --replace-all user.name AdamPettinger ; git config --global --replace-all user.email adam.l.pettinger@gmail.com'

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

alias vcsc='vcs custom --git --args'

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
    if [ -z "$ROS_DISTRO" ]
    then
        echo "No ROS_DISTRO set"
    elif [ "$ROS_DISTRO" == "noetic" ] || [ "$ROS_DISTRO" == "kinetic" ]
    then
        catkin build  -j $((($(nproc) + 1)/ 2)) --cmake-args -DCMAKE_BUILD_TYPE=Release $@
    else
        if [ -z "$1" ]
        then
            colcon build --parallel-workers $((($(nproc) + 1)/ 2)) --cmake-args -DCMAKE_BUILD_TYPE=Release
        else
            colcon build --parallel-workers $((($(nproc) + 1)/ 2)) --cmake-args -DCMAKE_BUILD_TYPE=Release --packages-select $@
        fi
    fi
}

# Build with all cores but 1 and a list of args for package name
# No args = full catkin build
cbf() {
    if [ -z "$ROS_DISTRO" ]
    then
        echo "No ROS_DISTRO set"
    elif [ "$ROS_DISTRO" == "noetic" ] || [ "$ROS_DISTRO" == "kinetic" ]
    then
        catkin build  -j $(($(nproc) - 1)) --cmake-args -DCMAKE_BUILD_TYPE=Release $@
    else
        if [ -z "$1" ]
        then
            colcon build --parallel-workers $(($(nproc) - 1)) --cmake-args -DCMAKE_BUILD_TYPE=Release
        else
            colcon build --parallel-workers $(($(nproc) - 1)) --cmake-args -DCMAKE_BUILD_TYPE=Release --packages-select $@
        fi
    fi
}

cb_debug() {
    if [ -z "$ROS_DISTRO" ]
    then
        echo "No ROS_DISTRO set"
    elif [ "$ROS_DISTRO" == "noetic" ] || [ "$ROS_DISTRO" == "kinetic" ]
    then
        catkin build  -j $(($(nproc) - 1)) --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo $@
    else
        if [ -z "$1" ]
        then
            colcon build --parallel-workers $(($(nproc) - 1)) --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo
        else
            colcon build --parallel-workers $(($(nproc) - 1)) --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo --packages-select $@
        fi
    fi
}

findtop() {
    if [ "$ROS_DISTRO" == "noetic" ] || [ "$ROS_DISTRO" == "kinetic" ]
    then
        if [ -z "$1" ]
        then
            rostopic list
        else
            rostopic list | grep $1
        fi
    else
        if [ -z "$1" ]
        then
            ros2 topic list
        else
            ros2 topic list | grep $1
        fi
    fi
}

findnode() {
    if [ "$ROS_DISTRO" == "noetic" ] || [ "$ROS_DISTRO" == "kinetic" ]
    then
        if [ -z "$1" ]
        then
            rosnode list
        else
            rosnode list | grep $1
        fi
    else
        if [ -z "$1" ]
        then
            ros2 node list
        else
            ros2 node list | grep $1
        fi
    fi
}

findsrv() {
    if [ "$ROS_DISTRO" == "noetic" ] || [ "$ROS_DISTRO" == "kinetic" ]
    then
        if [ -z "$1" ]
        then
            rosservice list
        else
            rosservice list | grep $1
        fi
    else
        if [ -z "$1" ]
        then
            ros2 service list
        else
            ros2 service list | grep $1
        fi
    fi
}

findparam() {
    if [ "$ROS_DISTRO" == "noetic" ] || [ "$ROS_DISTRO" == "kinetic" ]
    then
        if [ -z "$1" ]
        then
            rosparam list
        else
            rosparam list | grep $1
        fi
    else
        if [ -z "$1" ]
        then
            ros2 param list
        else
            ros2 param list | grep $1
        fi
    fi
}

howto_debug() {
    echo "Build with: --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo. Make sure this is in the launch: 'output=\"screen\", prefix=[\"xterm -e gdb --args\"],'"
}
howto_rosdep() {
    echo "rosdep install: 'rosdep install --from-paths . --ignore-src -y'"
}
howto_docker_build() {
    printf "To make a new image from a docker file:  \ndocker build -t <IMAGE_NAME> <DIR_WITH_DOCKERFILE>\n\n"
    printf "Pass an arg into Dockerfile with: '--build-arg <ARG_NAME>=<ARG_VAL>'\n\n"
    printf "If you want to use network interfaces in the docker: '--network=host'\n"
}
howto_docker_run() {
    printf "To make a new container from image:\n\n"
    echo "xhost +local:root &> /dev/null"
    echo "docker run -it --network=host --privileged --name <NEW_CONT_NAME> \ "
    echo "--mount type=bind,source=<ABS_PATH>,target=<ABS_PATH> \ "
    echo "--env=DISPLAY \ "
    echo "<IMAGE_NAME> /bin/bash"
    echo "xhost -local:root 1>/dev/null 2>&1"
}
howto_docker_exec() {
    echo "To launch already existing container 'docker start <CONTAINER_NAME>' and then 'docker exec -it /bin/bash'"
}
howto_ros2_create_pkg() {
    echo "Make packge with optional node and library: 'ros2 pkg create --build-type ament_cmake --node-name <node_name> --library-name <lib_name> <package_name>'"
}
howto_ros2_print_msgs() {
    echo "rosidl_generator_traits::to_yaml(msg)"
}
howto_ros2_topic_pub() {
    echo "Use python dictionary format, wrapped in quotes. Example:"
    echo "\"{linear: {x: 2.0, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: 1.8}}\""
    echo "To make the stamp of a header publish automagically:"
    echo "\"{'header':'auto'}\""
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
alias clang_cpp='find . -name '*.h' -or -name '*.hpp' -or -name '*.cpp' -o -name '*.c' -o -name '*.cc' -o -name '*.proto' | xargs clang-format-14 -i -style=file'

#
#   File navigation and formatting
#
# In a folder, recursively find and replace text
replace(){
    grep -lr -e $1 * | xargs sed -i "s/$1/$2/g" ;
}

alias edit_bashrc='code ~/.bashrc'
alias edit_bash_aliases='code ~/.bash_aliases'
alias edit_adam_aliases='code $ALIASES_DIR/scripts/users/adam.sh'

function source_aliases {
    if [[ -f "~/.bashrc" ]]; then
        source ~/.bashrc
    fi
    if [[ -f "~/.bash_aliases" ]]; then
        source ~/.bash_aliases
    fi
    if [[ -f "$ALIASES_DIR/scripts/users/adam.sh" ]]; then
        source $ALIASES_DIR/scripts/users/adam.sh
    fi
}

# Searching
function gr {
    grep -rn -I --exclude-dir=.git --color=always $1
}
function cgr {
    clear ; gr $1
}
function gri {
    grep -rin -I --exclude-dir=.git --color=always $1
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
        exit 0
    else
        mv "$@" "$ALIASES_DIR"/.adam_aliases/adam/
    fi
}
function putcopy {
    if [ -z "$1" ]; then
        exit 0
    else
        cp "$@" "$ALIASES_DIR"/.adam_aliases/adam/
    fi
}
function take {
    if [ -z "$1" ]; then
        exit 0
    else
        for file in "$@"; do
            # cp "$file" .
            cp "$ALIASES_DIR"/.adam_aliases/adam/"$file" .
        done
    fi
}
_temp_dir_completions()
{
    local cur
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"

    local files=$(ls "$ALIASES_DIR"/.adam_aliases/adam/)
    COMPREPLY=($(compgen -W "$files" -- "$cur"))
}
complete -F _temp_dir_completions take
complete -F _temp_dir_completions clear_adam_temp

# Rosdep install
function rosdep_install {
    if [ -z "$1" ]; then
        rosdep install --from-paths . --ignore-src -y
    else
        rosdep install --from-paths $1 --ignore-src -y
    fi
}

alias get_wifi_IP='echo "$(ifconfig | grep -A 1 'w' | tail -1 | cut -c 14- | cut -d " " -f 1)"'

# For setting rad alias
function rad_setup {
    local filename="rad.bash"
    local current_dir="$(pwd)"
    local home_dir="$HOME"

    # Traverse up the directory tree
    while [[ "$current_dir" != "/" && "$current_dir" != "$home_dir" ]]; do
        if [[ -f "$current_dir/$filename" ]]; then
            # If the file is found, create an alias to cd into the directory
            alias rad="cd '$current_dir' && ./rad.bash"
            echo "Alias 'rad' created for directory: $current_dir"
            return 0
        fi
        # Move up one directory
        current_dir="$(dirname "$current_dir")"
    done

    # If the file is not found, print an error message
    echo "File '$filename' not found in any parent directories up to the home directory."
    return 1
}

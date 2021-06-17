# Adam's Aliases
Useful bash aliases for developping on linux using catkin tools

## Install
```sh
git clone https://github.com/AdamPettinger/adam_aliases.git
cd adam_aliases
./install_adam_aliases.sh
```

## Highlight Aliases
1. `cb` and `cbf` run catkin build with half (`cb`) or all minus 1 (`cbf`) cores. Add specific packages after to only build specific ones, otherwise it builds all
2. `gitadam` sets the git configs to me so commits show up as mine
3. `..` and `...` and `....` and `.4`, etc, go up directories by 1, 2, 3, 4, etc levels
4. `source_ws` needs to be run in the top directory of a catkin workspace. It sources it. Useful for multi-workspace machines

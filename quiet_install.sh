#!/bin/bash

working_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $working_dir

# # Check for previous install by looking to see if .adam_aliases/ already exists
DIR="$working_dir/.adam_aliases/"
if [ -d "$DIR" ]; then
  exit -1 # TODO allow force install?
fi

# Create directory to store aliases info
mkdir .adam_aliases
touch .adam_aliases/current_user

# Now we add stuff to the bashrc
echo "" >> ~/.bashrc
echo "export ALIASES_DIR="$working_dir >> ~/.bashrc
echo "source $working_dir/.adam_aliases.bashrc" >> ~/.bashrc

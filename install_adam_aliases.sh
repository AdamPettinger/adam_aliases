#!/bin/bash

source scripts/colors.sh

working_dir=$(pwd)
text_green
echo "Installing with directory: "$working_dir
text_reset

# # Check for previous install by looking to see if .adam_aliases/ already exists
DIR="$working_dir/.adam_aliases/"
if [ -d "$DIR" ]; then
  text_red
  echo "It looks like you've already run this install script"
  echo "Skipping the install this time!"
  text_reset
  exit -1 # TODO allow force install?
fi

# Create directory to store aliases info
mkdir .adam_aliases
touch .adam_aliases/current_user

# Now we add stuff to the bashrc
echo "" >> ~/.bashrc
echo "source $working_dir/adam_aliases_bashrc" >> ~/.bashrc
echo "export ALIASES_DIR="$working_dir >> ~/.bashrc

# Ask if configure new user
echo "Do you want to configure a new user?"
read -p "'n' if you are already have a user stored in this repo (y/n) " resp
if [[ "$resp" = "y" ]]; then
  # Run the new user script
  export ALIASES_DIR=$working_dir
  cd $working_dir
  ./new_user_config.sh

else # Not configure new user
  text_red
  echo "Not configuring new user"
  echo "Make sure to 'source_USER' after this!"
  text_reset
fi

# TODO:
# - Add things to adam_aliases_bashrc
# - Uninstaller?
# - Add script to install common ubuntu tools (check email for deets)

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

# Ask if configure new user
echo "Do you want to configure a new user?"
read -p "'n' if you are already have a user stored in this repo (y/n) " resp
if [[ "$resp" = "y" ]]; then
  # Get this user name
  read -p "Enter your desired username. Should be unique! " username
  username=$(echo $username | sed 's/ //g')
  text_green
  echo "Setting username:" $username
  text_reset

  # Create a unique file for this user's personal aliases
  touch scripts/users/$username.sh
  echo '#!/bin/bash' >> scripts/users/$username.sh
  echo '' >> scripts/users/$username.sh
  echo '# ADD YOUR PERSONAL ALIASES HERE' >> scripts/users/$username.sh
  echo '' >> scripts/users/$username.sh
  echo '# An alias for changing the git user on this computer' >> scripts/users/$username.sh

  # Give the the git switching alias automatically
  read -p "Enter your Github username: " git_user
  read -p "Enter the email affiliated with your Github account: " git_email
  echo "alias git_$username='git config --global user.name $git_user ; git config --global user.email $git_email'" >> scripts/users/$username.sh

  # Add an entry to change_user script for this user
  echo "" >> scripts/change_user.sh
  echo "function source_$username {" >> scripts/change_user.sh
  echo "  echo '#!/bin/bash' > .adam_aliases/current_user #empties current user file" >> scripts/change_user.sh
  echo "  echo 'source $working_dir/scripts/users/$username.sh' >> .adam_aliases/current_user #set to you" >> scripts/change_user.sh
  echo "  source $working_dir/scripts/users/$username.sh #and source the new file now" >> scripts/change_user.sh
  echo "  git_$username #set new git user" >> scripts/change_user.sh
  echo "}" >> scripts/change_user.sh

else # Not configure new user
  text_red
  echo "Not configuring new user"
  echo "Make sure to 'source_USER' after this!"
  text_reset
fi

# Now we add stuff to the bashrc
echo "" >> ~/.bashrc
echo "source $working_dir/adam_aliases_bashrc" >> ~/.bashrc
echo "export ALIASES_DIR="$working_dir >> ~/.bashrc

# TODO:
# - Make configure user a seperate script
# - Add things to adam_aliases_bashrc
# - Uninstaller?
# - Add script to install common ubuntu tools (check email for deets)

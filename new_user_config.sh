#!/bin/bash

# Script to configure a new user
# Adds custom aliases file, add change user script, etc

source scripts/colors.sh

# Make sure we have installed
if [ -d "$ALIASES_DIR" ]; then
  cd $ALIASES_DIR
else
  text_red
  echo "Please run the install script first!"
  text_reset
  exit -1
fi

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
echo "function source_future_$username {" >> scripts/change_user.sh
echo "  echo '#!/bin/bash' > .adam_aliases/current_user #empties current user file" >> scripts/change_user.sh
echo "  echo 'source $ALIASES_DIR/scripts/users/$username.sh' >> .adam_aliases/current_user #set to you" >> scripts/change_user.sh
echo "  source $ALIASES_DIR/scripts/users/$username.sh #and source the new file now" >> scripts/change_user.sh
echo "  git_$username #set new git user" >> scripts/change_user.sh
echo "}" >> scripts/change_user.sh
echo "alias source_$username='source_future_$username ; source ~/.bashrc'" >> scripts/change_user.sh

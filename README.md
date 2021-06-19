# Adam's Aliases
A repo all about aliases:
  - Common aliases for all
  - Sync your personal aliases between computers
  - Manage multiple users with different personal aliases

# Install
If you already have a user config with custom aliases, skip to [Old User](#old-user).

## New User
First, check to see if this repository is already cloned/installed
```sh
cd $ALIASES_DIR
```

**If the directory was NOT found**, you need to clone and install this repo:
```sh
# Do this if $ALIASES_DIR did not exist!
# Otherwise go to the next code block
git clone https://github.com/AdamPettinger/adam_aliases.git
cd adam_aliases

# The following command will run the install script
# Select the option to configure a new user!
./install_adam_aliases.sh
```

**If the `cd $ALIASES_DIR` command worked** and took you a new directory, you just need to configure a new user for yourself!
```sh
./new_user_config.sh
```

After installing, source the aliases:
```sh
source ~/.basrhrc
source_USERNAME # username you selected above
```

You now have a file to add your personal aliases in, under `scripts/users/USERNAME.sh`. Additionally, you have 2 user-specific aliases:
```sh
# This uses your personal aliases until somebody else switches it
source_USERNAME

# This configures the git user to you until somebody switches it
git_USERNAME
```

Finally, you should push these changes! This allows you to use these same aliases on a different computer!
```sh
git_USERNAME # use your username from above
cd $ALIASES_DIR
git checkout -b USERNAME-initial-aliases # use your username from above
git add .
git commit -m "Added my user!"
git push origin USERNAME-initial-aliases # use your username from above
```

## Old User
First, check to see if this repository is already cloned/installed
```sh
cd $ALIASES_DIR
```

**If the directory was NOT found**, you need to clone and install this repo. Otherwise skip to the next step.
```sh
# Do this if $ALIASES_DIR did not exist!
# Otherwise go to the next code block
git clone https://github.com/AdamPettinger/adam_aliases.git
cd adam_aliases

# Do NOT configure a new user during the install
./install_adam_aliases.sh
```

Now just source your username as normal:
```sh
source ~/.bashrc
source_USERNAME # with your correct username
```

Note that if the `source_USERNAME` fails, you might need to pull the repository!

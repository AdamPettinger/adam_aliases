#!/bin/bash

alias git_noone='git config --global user.name --unset && git config --global user.email --unset'

function unset_user {
  # Unset git user
  git config --global user.name --unset
  git config --global user.email --unset

  # Unset current alias user
  echo '#!/bin/bash' > .adam_aliases/current_user
}

function source_future_adam {
  echo '#!/bin/bash' > $ALIASES_DIR/.adam_aliases/current_user #empties current user file
  echo 'source $ALIASES_DIR/scripts/users/adam.sh' >> $ALIASES_DIR/.adam_aliases/current_user #set to you
  source $ALIASES_DIR/scripts/users/adam.sh #and source the new file now
  git_adam #set new git user
  DIR="$ALIASES_DIR/.adam_aliases/adam"
  if [ ! -d "$DIR" ]; then
    mkdir "$DIR"
  fi
}
alias source_adam='source_future_adam ; source ~/.bashrc'

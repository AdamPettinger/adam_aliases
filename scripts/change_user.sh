#!/bin/bash

function unset_user {
  # Unset git user
  git config --global user.name --unset
  git config --global user.email --unset

  # Unset current alias user
  echo '#!/bin/bash' > .adam_aliases/current_user
}

function source_future_adam {
  echo '#!/bin/bash' > .adam_aliases/current_user #empties current user file
  echo 'source /home/picknik/adam_aliases/scripts/users/adam.sh' >> .adam_aliases/current_user #set to you
  source /home/picknik/adam_aliases/scripts/users/adam.sh #and source the new file now
  git_adam #set new git user
}
alias source_adam='source_future_adam ; source ~/.bashrc'

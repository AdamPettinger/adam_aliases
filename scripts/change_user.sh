#!/bin/bash

function unset_user {
  # Unset git user
  git config --global user.name --unset
  git config --global user.email --unset

  # Unset current alias user
  echo '#!/bin/bash' > .adam_aliases/current_user
}

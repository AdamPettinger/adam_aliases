#!/bin/bash

function unset_user {
  # Unset git user
  git config user.name --unset
  git config user.email --unset

  # Unset current alias user
  echo '#!/bin/bash' > .adam_aliases/current_user
}

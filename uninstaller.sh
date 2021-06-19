#!/bin/bash

# Uninstalls the aliases

# Really it is just removing the lines from the bashrc
sed -i '/adam_aliases/d' ~/.bashrc

# Let's remove the hidden file as well: this lets you run the installer again
cd $ALIASES_DIR
rm -r .adam_aliases/

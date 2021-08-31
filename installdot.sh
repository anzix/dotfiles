#!/bin/bash

# git clone моего dotfiles
git clone https://gitlab.com/anzix/dotfiles.git
cd dotfiles
mv README.md ~/Downloads
cd dotfiles
stow --adopt -vt ~ *

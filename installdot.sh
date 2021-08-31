#!/bin/bash

# git clone моего dotfiles
git clone https://gitlab.com/anzix/dotfiles.git
cd dotfiles
stow --adopt -vt ~ *

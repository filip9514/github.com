#! /bin/bash

# symbolic link in wrapper to this reppo
ln -s $(pwd)/start.sh ~/github.com/

# html files must be hard links in order to work correctly
ln $(pwd)/index.html ~/github.com/
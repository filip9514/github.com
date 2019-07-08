#! /bin/bash

export currentDir=$(pwd)
cd $HOME
tree -L 2 -H https://github.com -d $HOME/github.com > $HOME/github.com/tree.html
firefox $HOME/github.com/index.html  2>&1 | tee /dev/null  > /dev/null &
cd $currentDir

#! /bin/bash

export currentDir=$(pwd)
cd $HOME
tree -L 2 -H https://gh/ -d $HOME/gh > $HOME/gh/report/tree.html
#firefox $HOME/gh/report/index.html  2>&1 | tee /dev/null  > /dev/null &
firefox http://localhost:5000/report/main
cd $currentDir

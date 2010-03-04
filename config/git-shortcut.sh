#!/bin/bash

git config --global alias.cf config
git cf --global alias.cfg 'config --global'
git cfg color.ui auto
git cfg alias.st status
git cfg alias.lg 'log --pretty=oneline --abbrev=6'
git cfg alias.cm commit
git cfg alias.cmm 'commit -m'
git cfg alias.co 'checkout'
git cfg alias.coh 'checkout HEAD'
git cfg alias.br 'branch'
git cfg alias.unp 'log --pretty=oneline --abbrev=6 origin/master..HEAD'
git cfg alias.dfs 'diff --staged'

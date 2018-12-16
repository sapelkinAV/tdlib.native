#!/usr/bin/env zsh

git add *
git commit -m "yet another try"
git push origin
git tag -a $1 -am "Yet another try for the god of tries"
git push origin --tags $1

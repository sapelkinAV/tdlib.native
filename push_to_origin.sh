#!/usr/bin/env zsh

git add *
git commit -m "another try"
git tag -a $1 -m "Another try for the god of tries"
git push origin --tags $1

#!/usr/bin/bash
#copies files from another repo into the current repo

git log --pretty=email --patch-with-stat --reverse -- $1 | (git am)

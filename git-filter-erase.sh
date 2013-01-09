#/bin/bash
#
# Copyright 2012 Author: Jose Rojas (jrojas@redlinesolutions.co)
# Source: https://github.com/J-Rojas/git-utils/
# 
# Licensed under GPL version 3 : http://www.gnu.org/licenses/gpl.html
#
# Please retain the copyright, source and license terms above.
#

if [[ !$# -gt 0 ]]
then
   echo "git-filter-erase: a useful wrapper around git-filter-branch that removes files from your git history permanently"
   echo "Usage: git-filter-erase [--now] file_paths_to_filter"
   echo " Options: "
   echo "   --now: destroys and garbage collects filtered files."
   exit -1
fi

NOW=
if [ $1 == '--now' ];
then
   NOW=true
   shift;
fi

git filter-branch -f --index-filter "git rm --cached --ignore-unmatch $1"   --prune-empty --tag-name-filter cat -- --all

if [ $NOW ];
then
    rm -rf .git/refs/original/
    git reflog expire --expire=now --all
    git gc --aggressive --prune=now
fi

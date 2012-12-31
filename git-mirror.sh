#/bin/bash
#
# Copyright 2012 Author: Jose Rojas (jrojas@redlinesolutions.co)
# Source: https://github.com/J-Rojas/git-utils/

# Licensed under GPL version 3 : http://www.gnu.org/licenses/gpl.html
#
# Please retain the copyright, source and license terms above.
#

regex='^(.+?)@(.+?):(.+)/([^/]+)?$'

if [[ $# -ne 1 || !($1 =~ $regex) ]]
then
   echo "Usage: git-mirror [username]@[servername]:/[git repo path to create on server]"
   exit -1
fi

if [[ $1 =~ $regex ]]
then
  user="${BASH_REMATCH[1]}"
  server="${BASH_REMATCH[2]}"
  dir="${BASH_REMATCH[3]}"
  git="${BASH_REMATCH[4]}"
  echo "Mirroring current repo to ${server}:${dir}/${git}"
fi

if [[ $git == '' ]]
then
  git="."
fi

echo "
mkdir -p $dir
cd $dir
git --bare init $git
" |
ssh "${user}@${server}" "bash -s --"

git push --mirror "ssh://${user}@${server}/${dir}/${git}"

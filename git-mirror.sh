#/bin/bash
#
# Copyright 2012 Author: Jose Rojas (jrojas@redlinesolutions.co)
#  
# Licensed under GPL version 3 : http://www.gnu.org/licenses/gpl.html
#
# Please retain the copyright and license terms above.
#

if [ $# -ne 1 ]
then
   echo "Usage: git-mirror [username]@[servername]:/[git repo path to create on server]"
   exit -1
fi

echo $1

regex='^(.+?):(.+)/([^/]+)?$'
if [[ $1 =~ $regex ]]
then
  server="${BASH_REMATCH[1]}"
  dir="${BASH_REMATCH[2]}"
  git="${BASH_REMATCH[3]}"
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
ssh $server "bash -s --"

git push --mirror ssh://${server}/${dir}/${git}

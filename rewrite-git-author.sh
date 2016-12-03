#!/bin/bash
# Refer to : https://help.github.com/articles/changing-author-info/

function rewrite_git_author() {
  git filter-branch --env-filter '

OLD_EMAIL="your-old-email@example.com"
CORRECT_NAME="Your Correct Name"
CORRECT_EMAIL="your-correct-email@example.com"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
}

function execute_git_push() {
  while :
  do
    echo -n "Execute 'git push --force' ? [y/n] : "
    read answer

    if [ "$answer" = "y" ]; then
      echo ""
      git push --force --tags origin 'refs/heads/*'
      break
    elif [ "$answer" = "n" ]; then
      break
    fi
  done
}

if [ $# -ne 1 ]; then
  echo "Usage : $0 <repository url list file>"
  exit 1
fi

repo_list=$1

for repo_url in `cat $repo_list`
do
  echo -e "\nTarget repository : $repo_url\n"

  git clone --bare $repo_url

  if [ $? -ne 0 ]; then
    echo "Failed to execute git clone. This repository is skipped."
    continue
  fi

  dir=`basename $repo_url`
  cd $dir
  if [ $? -ne 0 ]; then
    echo "Failed to execute cd command. This repository is skipped."
    continue
  fi

  rewrite_git_author

  echo -e "\nrewrite_git_author exit-status : $?"

  execute_git_push

  cd ..
done


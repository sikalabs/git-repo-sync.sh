#!/bin/sh

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <branch> <repo1> <repo2>"
    exit 1
fi

BRANCH=$1
REPO1=$2
REPO2=$3

mkdir tmp
cd tmp

git init

git remote add repo1 $REPO1
git remote add repo2 $REPO2

git fetch repo1
git fetch repo2

git switch -c repo1-$BRANCH repo1/$BRANCH
git pull repo2 $BRANCH
git push repo2 repo1-$BRANCH:$BRANCH

git switch -c repo2-$BRANCH repo2/$BRANCH
git pull repo1 $BRANCH
git push repo1 repo2-$BRANCH:$BRANCH

cd ..
rm -rf tmp

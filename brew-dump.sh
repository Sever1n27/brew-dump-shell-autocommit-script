#!/bin/sh
if [ -d ".git" ] 
then
    echo "Git repository exists" 
    brew bundle dump --force
    wait
    MESSAGE=$(git diff | grep '^[-+][^-+]' 2>&1)
    wait
    if [ -z "${MESSAGE}" ]
    then
        echo "Diff is empty, there is no changes"
    else
        echo "$MESSAGE"
        git add .
        wait
        git commit -m "$MESSAGE"
        git push
    fi
else
    echo "Error: Git repository does not exists"
fi
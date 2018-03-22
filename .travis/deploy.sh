#!/bin/bash

# print outputs and exit on first failure
set -xe

if [ $TRAVIS_BRANCH == "develop" ] ; then

    echo "Set up permissions"
    # setup ssh agent, git config and remote
    eval "$(ssh-agent -s)"
    chmod 600 travis_rsa
    ssh-add travis_rsa
    git remote add deploy "travis@138.68.27.217:/var/www/develop.reguluswallet.com/.git"
    git config user.name "suxur"
    git config user.email "suxur@me.com"

    # commit compressed files and push it to remote
    git add .
    git status # debug
    git commit -m "Deploy from Travis - build {$TRAVIS_BUILD_NUMBER}"
    
    echo "Send build"
    git push -f deploy develop

else

    echo "No deploy script for branch '$TRAVIS_BRANCH'"

fi



#!/bin/bash

# print outputs and exit on first failure
set -xe

if [ $TRAVIS_BRANCH == "develop" ] ; then

    # setup ssh agent, git config and remote
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/travis_rsa
    git remote add deploy "travis@138.68.27.217:/var/www/develop.reguluswallet.com"
    git config user.name "suxur"
    git config user.email "suxur@me.com"

    # commit compressed files and push it to remote
    git add .
    git status # debug
    git commit -m "Deploy Site"
    git push -f deploy HEAD:master

else

    echo "No deploy script for branch '$TRAVIS_BRANCH'"

fi


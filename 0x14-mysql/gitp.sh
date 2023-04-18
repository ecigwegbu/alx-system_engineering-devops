#!/usr/bin/env bash
# Git add, commit and push
# Takes one argument - the commit comment; default is "Routine Update"

# Add all changes in current directory
git add .

# Commit Changes
if [ "$1" ]; then
	git commit -m "$1"
else
	git commit -m "Routine Update"
fi

# push commit to git. No password required if
# git has been properly setup with a PAT
git push

# Good job. Now go back and do something useful ...:)
echo "-----Changes commited.-----"


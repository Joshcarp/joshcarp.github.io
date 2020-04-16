#!/bin/sh
# # If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

go run deletefiles.go 

cd _source
# Build the project.
hugo -t hugo-coder # if using a theme, replace with `hugo -t <YOURTHEME>`



# Go To Public folder
mv -f public/* ../

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
# git push origin master
git push origin master
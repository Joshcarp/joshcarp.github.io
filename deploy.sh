#!/bin/sh
# # If a command fails then the deploy stops
set -e
mkdir -p docs
cp CNAME docs
cd _source
# Build the project.
hugo -t hugo-coder # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
mv -f public/* ../docs

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi

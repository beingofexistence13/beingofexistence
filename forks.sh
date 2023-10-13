#!/bin/bash

# Your GitHub username
username="beingofexistence"

# Your GitHub token
token="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"

# List of repositories to fork
repos=(
    "repo1_owner/repo1_name"
    "repo2_owner/repo2_name"
    # Add more repos to the list as needed
)

for repo in "${repos[@]}"
do
    # Check if the fork already exists
    status_code=$(curl -o /dev/null -s -w "%{http_code}\n" -u "$username:$token" https://api.github.com/repos/$username/$(echo $repo | cut -d'/' -f 2))

    if [ $status_code == 404 ]; then
        # If the fork does not exist, create it
        curl -u "$username:$token" https://api.github.com/repos/$repo/forks -d ''
        echo "Forked $repo"
    else
        echo "Fork of $repo already exists in your GitHub account. Trying to fork next repository."
    fi
done
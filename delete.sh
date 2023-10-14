#!/bin/bash

# Your GitHub username
username="your_username"

# Your GitHub token
token="your_token"

# The name of the repositories you want to delete
repos=("repo1" "repo2" "repo3")

for repo in "${repos[@]}"
do
  echo "Deleting $repo"
  curl -X DELETE -H "Authorization: token $token" "https://api.github.com/repos/$username/$repo"
done

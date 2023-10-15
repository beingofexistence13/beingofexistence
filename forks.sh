#!/bin/bash

# JavaScript array of repos
declare -a repos=(
    "https://github.com/dotnet/runtime"
    "https://github.com/kaldi-asr/kaldi"
)

# Your GitHub username
username="beingofexistence"

# Loop over all repo URLs
for repo in "${repos[@]}"
do
    # Extract owner and repo name from URL
    owner=$(echo $repo | cut -d'/' -f4)
    repo_name=$(echo $repo | cut -d'/' -f5)

    # Check if the fork already exists in your account
    status_code=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: token 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" "https://api.github.com/repos/$username/$repo_name")

    if [ $status_code == 404 ]
    then
        # Use curl to send POST request to GitHub API for forking a repository and save the response
        response=$(curl -s -X POST -H "Authorization: token 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" "https://api.github.com/repos/$owner/$repo_name/forks")

        # Check if the response contains an error message
        if echo "$response" | grep -q "\"message\""; then
            # Extract and print the error message
            error_message=$(echo "$response" | grep "\"message\"" | cut -d'"' -f4)
            echo "Error forking $repo_name: $error_message"
        else
            echo "$repo_name has been successfully forked to your account."
        fi
    fi
    # Delay for 1 second before the next request
    sleep 1
done

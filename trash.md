# #!/bin/bash

# # Your GitHub username
# username="beingofexistence"

# # Your GitHub token
# token="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"

# # List of repositories to fork
# repos=(
#     "repo1_owner/repo1_name"
#     "repo2_owner/repo2_name"
#     # Add more repos to the list as needed
# )

# for repo in "${repos[@]}"
# do
#     # Check if the fork already exists
#     status_code=$(curl -o /dev/null -s -w "%{http_code}\n" -u "$username:$token" https://api.github.com/repos/$username/$(echo $repo | cut -d'/' -f 2))

#     if [ $status_code == 404 ]; then
#         # If the fork does not exist, create it
#         curl -u "$username:$token" https://api.github.com/repos/$repo/forks -d ''
#         echo "Forked $repo"
#     else
#         echo "Fork of $repo already exists in your GitHub account. Trying to fork next repository."
#     fi
# done

# #!/bin/bash

# # JavaScript array of repos
# declare -a repos=(
#     "https://github.com/beingofexistence/docker-openvscode-server"
#     "https://github.com/beingofexistence/docker-code-server"
#     "https://github.com/beingofexistence/docker-openvscode-server"
#     "https://github.com/beingofexistence/docker-code-server"
#     "https://github.com/beingofexistence/code-server-railway"
#     "https://github.com/beingofexistence/friday-max"
#     "https://github.com/beingofexistence/theia-vscode"
#     "https://github.com/beingofexistence/thirdweb-dashboard-web3"
#     "https://github.com/beingofexistence/givenus0026"
#     "https://github.com/beingofexistence/multiverse"
#     "https://github.com/beingofexistence/appflow-native"
#     "https://github.com/beingofexistence/dx-native"
#     "https://github.com/beingofexistence/nextjs-portfolio-pageview-counter"
#     "https://github.com/beingofexistence/ai-photo-restorer"
#     "https://github.com/beingofexistence/inpainter-stable-diffusion"
#     "https://github.com/beingofexistence/mongodb-starter-demo"
#     "https://github.com/beingofexistence/mongodb-starter"
#     "https://github.com/beingofexistence/netlify-express"
#     "https://github.com/beingofexistence/netlify-alchemy-dapp-boilerplates"
#     "https://github.com/beingofexistence/scribble-diffusion"
#     "https://github.com/beingofexistence/nextjs-openai-doc-search-starter"
#     "https://github.com/beingofexistence/chatbot-ui"
#     "https://github.com/beingofexistence/nextjs-chat-demo"
#     "https://github.com/beingofexistence/nothing"
#     "https://github.com/beingofexistence/hackIn"
#     "https://github.com/beingofexistence/connect"
#     "https://github.com/beingofexistence/nextjs-libraries"
#     "https://github.com/beingofexistence/path-gradient"
#     "https://github.com/beingofexistence/splash-screen"
#     "https://github.com/beingofexistence/todo"
#     "https://github.com/beingofexistence/laravel"
#     "https://github.com/beingofexistence/template-typescript-node"
#     "https://github.com/beingofexistence/express-typescript"
#     "https://github.com/beingofexistence/friday3"
#     "https://github.com/beingofexistence/app-directory"
#     "https://github.com/beingofexistence/threejs-nextjs"
# )

# # Loop over all repo URLs
# for repo in "${repos[@]}"
# do
#     # Extract owner and repo name from URL
#     owner=$(echo $repo | cut -d'/' -f4)
#     repo_name=$(echo $repo | cut -d'/' -f5)

#     # Use curl to send DELETE request to GitHub API
#     curl -X DELETE -H "Authorization: token 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" "https://api.github.com/repos/$owner/$repo_name"
# done

# #!/bin/bash

# # JavaScript array of repos
# declare -a repos=(
#     "https://github.com/beingofexistence/docker-openvscode-server"
#     ...
#     "https://github.com/beingofexistence/threejs-nextjs"
# )

# # Loop over all repo URLs
# for repo in "${repos[@]}"
# do
#     # Extract owner and repo name from URL
#     owner=$(echo $repo | cut -d'/' -f4)
#     repo_name=$(echo $repo | cut -d'/' -f5)

#     # Use curl to send POST request to GitHub API for forking a repository
#     curl -X POST -H "Authorization: token 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" "https://api.github.com/repos/$owner/$repo_name/forks"
# done

#!/bin/bash

# JavaScript array of repos
declare -a repos=(
    "https://github.com/waditu/tushare"
    "https://github.com/ramsey/uuid"
    "https://github.com/FavioVazquez/ds-cheatsheets"
    "https://github.com/ethereum/EIPs"
    "https://github.com/Netflix/eureka"
    "https://github.com/mfornos/awesome-microservices"
    "https://github.com/laradock/laradock"
    "https://github.com/fengyuanchen/cropperjs"
    "https://github.com/ppy/osu"
    "https://github.com/Juanpe/SkeletonView"
    "https://github.com/TypeStrong/ts-node"
    "https://github.com/nicklockwood/iCarousel"
    "https://github.com/spotify/annoy"
    "https://github.com/avwo/whistle"
    "https://github.com/pjialin/py12306"
    "https://github.com/morhetz/gruvbox"
    "https://github.com/frida/frida"
    "https://github.com/CosmicMind/Material"
    "https://github.com/ionic-team/stencil"
    "https://github.com/reactioncommerce/reaction"
    "https://github.com/dotnet/AspNetCore.Docs"
    "https://github.com/facebook/watchman"
    "https://github.com/BrowserSync/browser-sync"
    "https://github.com/wilsonfreitas/awesome-quant"
    "https://github.com/raysan5/raylib"
    "https://github.com/twitter/twemproxy"
    "https://github.com/Miserlou/Zappa"
    "https://github.com/alex000kim/nsfw_data_scraper"
    "https://github.com/tj/co"
    "https://github.com/mobile-shell/mosh"
    "https://github.com/sinatra/sinatra"
    "https://github.com/1995parham/github-do-not-ban-us"
    "https://github.com/postmanlabs/httpbin"
    "https://github.com/jaredreich/pell"
    "https://github.com/mail-in-a-box/mailinabox"
    "https://github.com/firebase/functions-samples"
    "https://github.com/tmuxinator/tmuxinator"
    "https://github.com/karma-runner/karma"
    "https://github.com/ginuerzh/gost"
    "https://github.com/gopherjs/gopherjs"
    "https://github.com/newTendermint/awesome-bigdata"
    "https://github.com/elastic/beats"
    "https://github.com/facebookresearch/detr"
    "https://github.com/redis/redis-py"
    "https://github.com/phobal/ivideo"
    "https://github.com/davisking/dlib"
    "https://github.com/junyanz/CycleGAN"
    "https://github.com/h4cc/awesome-elixir"
    "https://github.com/jamiebuilds/babel-handbook"
    "https://github.com/phil-opp/blog_os"
    "https://github.com/TGSAN/CMWTAT_Digital_Edition"
    "https://github.com/idank/explainshell"
    "https://github.com/donnemartin/awesome-aws"
    "https://github.com/fathyb/carbonyl"
    "https://github.com/alexjc/neural-enhance"
    "https://github.com/GoogleChrome/workbox"
    "https://github.com/aurelia/framework"
    "https://github.com/mailhog/MailHog"
    "https://github.com/NetEase/pomelo"
    "https://github.com/LightTable/LightTable"
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

    # Wait for 3 seconds before the next request
    sleep 3
done

#!/bin/bash

# JavaScript array of repos
declare -a repos=(
"https://github.com/dotnet/runtime"
"https://github.com/kaldi-asr/kaldi"
"https://github.com/Tencent/omi"
"https://github.com/wix/react-native-navigation"
"https://github.com/Homebrew/homebrew-core"
"https://github.com/jupyterlab/jupyterlab"
"https://github.com/markets/awesome-ruby"
"https://github.com/tinymce/tinymce"
"https://github.com/surmon-china/vue-awesome-swiper"
"https://github.com/webrtc/samples"
"https://github.com/openai/openai-python"
"https://github.com/apache/apisix"
"https://github.com/auchenberg/volkswagen"
"https://github.com/ansible/awx"
"https://github.com/tw93/Pake"
"https://github.com/krasimir/react-in-patterns"
"https://github.com/rust-lang/rust-analyzer"
"https://github.com/tidwall/gjson"
"https://github.com/facebookarchive/stetho"
"https://github.com/alibaba/hooks"
"https://github.com/twbs/bootstrap-sass"
"https://github.com/akka/akka"
"https://github.com/marko-js/marko"
"https://github.com/mishoo/UglifyJS"
"https://github.com/sivel/speedtest-cli"
"https://github.com/denisidoro/navi"
"https://github.com/node-inspector/node-inspector"
"https://github.com/jwagner/smartcrop.js"
"https://github.com/valinet/ExplorerPatcher"
"https://github.com/microsoft/ai-edu"
"https://github.com/Instagram/IGListKit"
"https://github.com/ianyh/Amethyst"
"https://github.com/apache/arrow"
"https://github.com/microsoft/qlib"
"https://github.com/greenrobot/greenDAO"
"https://github.com/uxsolutions/bootstrap-datepicker"
"https://github.com/unixorn/awesome-zsh-plugins"
"https://github.com/google/brotli"
"https://github.com/FaridSafi/react-native-gifted-chat"
"https://github.com/OpenRA/OpenRA"
"https://github.com/apache/predictionio"
"https://github.com/extrawurst/gitui"
"https://github.com/sqshq/piggymetrics"
"https://github.com/codelucas/newspaper"
"https://github.com/tpope/vim-surround"
"https://github.com/rt2zz/redux-persist"
"https://github.com/vicc/chameleon"
"https://github.com/systemjs/systemjs"
"https://github.com/nats-io/nats-server"
"https://github.com/memcached/memcached"
"https://github.com/java-decompiler/jd-gui"
"https://github.com/koreader/koreader"
"https://github.com/php-fig/fig-standards"
"https://github.com/vlucas/phpdotenv"
"https://github.com/arut/nginx-rtmp-module"
"https://github.com/scottbez1/smartknob"
"https://github.com/karpathy/llama2.c"
"https://github.com/wistbean/learn_python3_spider"
"https://github.com/loverajoel/jstips"
"https://github.com/capistrano/capistrano"
"https://github.com/gizak/termui"
"https://github.com/graphql/dataloader"
"https://github.com/sindresorhus/pure"
"https://github.com/wong2/chatgpt-google-extension"
"https://github.com/RPCS3/rpcs3"
"https://github.com/Rapptz/discord.py"
"https://github.com/networkx/networkx"
"https://github.com/zhihu/Matisse"
"https://github.com/Tonejs/Tone.js"
"https://github.com/SVProgressHUD/SVProgressHUD"
"https://github.com/alibaba/lowcode-engine"
"https://github.com/leisurelicht/wtfpython-cn"
"https://github.com/qyuhen/book"
"https://github.com/phanan/htaccess"
"https://github.com/playframework/playframework"
"https://github.com/robbiehanson/CocoaAsyncSocket"
"https://github.com/daimajia/AndroidViewAnimations"
"https://github.com/HandBrake/HandBrake"
"https://github.com/golang/groupcache"
"https://github.com/redis/ioredis"
"https://github.com/youth5201314/banner"
"https://github.com/daimajia/AndroidSwipeLayout"
"https://github.com/ajv-validator/ajv"
"https://github.com/alibaba/tengine"
"https://github.com/jhuangtw/xg2xg"
"https://github.com/Automattic/wp-calypso"
"https://github.com/phacility/phabricator"
"https://github.com/Kotlin/kotlinx.coroutines"
"https://github.com/davidshimjs/qrcodejs"
"https://github.com/halfrost/Halfrost-Field"
"https://github.com/amfe/lib-flexible"
"https://github.com/dmlc/dgl"
"https://github.com/polybar/polybar"
"https://github.com/tomnomnom/gron"
"https://github.com/jikexueyuanwiki/tensorflow-zh"
"https://github.com/zenorocha/alfred-workflows"
"https://github.com/docker/kitematic"
"https://github.com/gaearon/react-hot-loader"
"https://github.com/gnab/remark"
"https://github.com/kubesphere/kubesphere"
"https://github.com/iggredible/Learn-Vim"
"https://github.com/nusr/hacker-laws-zh"
"https://github.com/segmentio/evergreen"
"https://github.com/answershuto/learnVue"
"https://github.com/troyeguo/koodo-reader"
"https://github.com/roots/sage"
"https://github.com/tiangolo/typer"
"https://github.com/primer/css"
"https://github.com/gruntjs/grunt"
"https://github.com/rubocop/rubocop"
"https://github.com/fogleman/primitive"
"https://github.com/slackhq/nebula"
"https://github.com/linnovate/mean"
"https://github.com/google/guice"
"https://github.com/spree/spree"
"https://github.com/google-deepmind/deepmind-research"
"https://github.com/xgrommx/awesome-redux"
"https://github.com/dzenbot/DZNEmptyDataSet"
"https://github.com/reactos/reactos"
"https://github.com/VerbalExpressions/JSVerbalExpressions"
"https://github.com/bailicangdu/node-elm"
"https://github.com/samber/lo"
"https://github.com/s-matyukevich/raspberry-pi-os"
"https://github.com/xiandanin/magnetW"
"https://github.com/fluent/fluentd"
"https://github.com/diegomura/react-pdf"
"https://github.com/openai/evals"
"https://github.com/cloudwu/skynet"
"https://github.com/sindresorhus/type-fest"
"https://github.com/PHPOffice/PhpSpreadsheet"
"https://github.com/tpope/vim-pathogen"
"https://github.com/postgres/postgres"
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

# # Loop over all repo URLs
# for repo in "${repos[@]}"
# do
#     # Extract owner and repo name from URL
#     owner=$(echo $repo | cut -d'/' -f4)
#     repo_name=$(echo $repo | cut -d'/' -f5)

#     # Check if the fork already exists in your account
#     status_code=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: token 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" "https://api.github.com/repos/$username/$repo_name")

#     if [ $status_code == 404 ]
#     then
#         # Use curl to send POST request to GitHub API for forking a repository
#         curl -X POST -H "Authorization: token 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" "https://api.github.com/repos/$owner/$repo_name/forks"
#     else
#         echo "The fork $repo_name already exists in your account."
#     fi
# done


# #!/bin/bash

# # JavaScript array of repos
# declare -a repos=(
#     "https://github.com/beingofexistence/docker-openvscode-server"
#     ...
#     "https://github.com/beingofexistence/threejs-nextjs"
# )

# # Your GitHub username
# username="your_username"

# # Loop over all repo URLs
# for repo in "${repos[@]}"
# do
#     # Extract owner and repo name from URL
#     owner=$(echo $repo | cut -d'/' -f4)
#     repo_name=$(echo $repo | cut -d'/' -f5)

#     # Check if the fork already exists in your account
#     status_code=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: token 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" "https://api.github.com/repos/$username/$repo_name")

#     if [ $status_code == 404 ]
#     then
#         # Use curl to send POST request to GitHub API for forking a repository and save the response
#         response=$(curl -s -X POST -H "Authorization: token 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" "https://api.github.com/repos/$owner/$repo_name/forks")

#         # Check if the response contains an error message
#         if echo "$response" | grep -q "\"message\""; then
#             # Extract and print the error message
#             error_message=$(echo "$response" | grep "\"message\"" | cut -d'"' -f4)
#             echo "Error forking $repo_name: $error_message"
#         fi
#     fi
# done

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
    sleep 2
done

#!/bin/bash

# JavaScript array of repos
declare -a repos=(
    "https://github.com/winstonjs/winston"
    "https://github.com/camsong/You-Dont-Need-jQuery"
    "https://github.com/termux/termux-app"
    "https://github.com/avajs/ava"
    "https://github.com/grafana/loki"
    "https://github.com/futurice/android-best-practices"
    "https://github.com/Homebrew/homebrew-cask"
    "https://github.com/Swordfish90/cool-retro-term"
    "https://github.com/XIU2/TrackersListCollection"
    "https://github.com/parse-community/parse-server"
    "https://github.com/framer/motion"
    "https://github.com/jumpserver/jumpserver"
    "https://github.com/osquery/osquery"
    "https://github.com/posquit0/Awesome-CV"
    "https://github.com/ruby/ruby"
    "https://github.com/typicode/lowdb"
    "https://github.com/BradLarson/GPUImage"
    "https://github.com/notepad-plus-plus/notepad-plus-plus"
    "https://github.com/alan2207/bulletproof-react"
    "https://github.com/palantir/blueprint"
    "https://github.com/checkcheckzz/system-design-interview"
    "https://github.com/lensterxyz/lenster"
    "https://github.com/dotnet/maui"
    "https://github.com/n0shake/Public-APIs"
    "https://github.com/mli/paper-reading"
    "https://github.com/verekia/js-stack-from-scratch"
    "https://github.com/arendst/Tasmota"
    "https://github.com/ReactiveCocoa/ReactiveCocoa"
    "https://github.com/openai/gpt-2"
    "https://github.com/phoenixframework/phoenix"
    "https://github.com/wesm/pydata-book"
    "https://github.com/YunaiV/ruoyi-vue-pro"
    "https://github.com/processing/p5.js"
    "https://github.com/kovidgoyal/kitty"
    "https://github.com/imDazui/Tvlist-awesome-m3u-m3u8"
    "https://github.com/gpakosz/.tmux"
    "https://github.com/cookiecutter/cookiecutter"
    "https://github.com/PHPMailer/PHPMailer"
    "https://github.com/gorilla/websocket"
    "https://github.com/facert/awesome-spider"
    "https://github.com/nikitavoloboev/my-mac"
    "https://github.com/apache/rocketmq"
    "https://github.com/valyala/fasthttp"
    "https://github.com/quii/learn-go-with-tests"
    "https://github.com/microsoft/vcpkg"
    "https://github.com/luong-komorebi/Awesome-Linux-Software"
    "https://github.com/basarat/typescript-book"
    "https://github.com/ReactiveX/RxAndroid"
    "https://github.com/AtsushiSakai/PythonRobotics"
    "https://github.com/hapijs/joi"
    "https://github.com/openai/chatgpt-retrieval-plugin"
    "https://github.com/graphql/graphql-js"
    "https://github.com/FelisCatus/SwitchyOmega"
    "https://github.com/facebookarchive/pop"
    "https://github.com/restic/restic"
    "https://github.com/didi/DoKit"
    "https://github.com/pubkey/rxdb"
    "https://github.com/afollestad/material-dialogs"
    "https://github.com/svg/svgo"
    "https://github.com/FredKSchott/snowpack"
    "https://github.com/Reactive-Extensions/RxJS"
    "https://github.com/SnapKit/SnapKit"
    "https://github.com/TeamStuQ/skill-map"
    "https://github.com/plotly/dash"
    "https://github.com/google/eng-practices"
    "https://github.com/dennybritz/reinforcement-learning"
    "https://github.com/fastai/fastbook"
    "https://github.com/enaqx/awesome-pentest"
    "https://github.com/sebastianbergmann/phpunit"
    "https://github.com/dotnet/core"
    "https://github.com/railsware/upterm"
    "https://github.com/spmallick/learnopencv"
    "https://github.com/tobiasahlin/SpinKit"
    "https://github.com/gorilla/mux"
    "https://github.com/jsdom/jsdom"
    "https://github.com/adobe-fonts/source-code-pro"
    "https://github.com/nuysoft/Mock"
    "https://github.com/iampawan/FlutterExampleApps"
    "https://github.com/saleor/saleor"
    "https://github.com/oracle/graal"
    "https://github.com/facebookexperimental/Recoil"
    "https://github.com/nginx/nginx"
    "https://github.com/kamranahmedse/driver.js"
    "https://github.com/ruanyf/jstraining"
    "https://github.com/Anuken/Mindustry"
    "https://github.com/vuejs/vue-router"
    "https://github.com/CarGuo/GSYVideoPlayer"
    "https://github.com/PanJiaChen/vue-admin-template"
    "https://github.com/jorgebucaran/hyperapp"
    "https://github.com/reduxjs/reselect"
    "https://github.com/grpc/grpc-go"
    "https://github.com/mybatis/mybatis-3"
    "https://github.com/dylanaraps/neofetch"
    "https://github.com/dhg/Skeleton"
    "https://github.com/jbhuang0604/awesome-computer-vision"
    "https://github.com/apache/shardingsphere"
    "https://github.com/elastic/kibana"
    "https://github.com/zergtant/pytorch-handbook"
    "https://github.com/wekan/wekan"
    "https://github.com/mifi/lossless-cut"
    "https://github.com/crystal-lang/crystal"
    "https://github.com/ftlabs/fastclick"
    "https://github.com/icsharpcode/ILSpy"
    "https://github.com/aquasecurity/trivy"
    "https://github.com/brettwooldridge/HikariCP"
    "https://github.com/toml-lang/toml"
    "https://github.com/semantic-release/semantic-release"
    "https://github.com/valeriansaliou/sonic"
    "https://github.com/square/picasso"
    "https://github.com/SBoudrias/Inquirer.js"
    "https://github.com/Prinzhorn/skrollr"
    "https://github.com/iperov/DeepFaceLive"
    "https://github.com/you-dont-need/You-Dont-Need-JavaScript"
    "https://github.com/google/web-starter-kit"
    "https://github.com/thangchung/awesome-dotnet-core"
    "https://github.com/linlinjava/litemall"
    "https://github.com/jcjohnson/neural-style"
    "https://github.com/tpope/vim-fugitive"
    "https://github.com/huggingface/diffusers"
    "https://github.com/desktop/desktop"
    "https://github.com/bcit-ci/CodeIgniter"
    "https://github.com/alibaba/weex"
    "https://github.com/redis/go-redis"
    "https://github.com/openai/CLIP"
    "https://github.com/SnapKit/Masonry"
    "https://github.com/google/flexbox-layout"
    "https://github.com/Tencent/ncnn"
    "https://github.com/tj/n"
    "https://github.com/copy/v86"
    "https://github.com/matomo-org/matomo"
    "https://github.com/dandavison/delta"
    "https://github.com/HelloZeroNet/ZeroNet"
    "https://github.com/facebook/relay"
    "https://github.com/mojs/mojs"
    "https://github.com/MichMich/MagicMirror"
    "https://github.com/yudai/gotty"
    "https://github.com/dotnet/roslyn"
    "https://github.com/zsh-users/zsh-syntax-highlighting"
    "https://github.com/Vonng/ddia"
    "https://github.com/airbnb/visx"
    "https://github.com/nosir/cleave.js"
    "https://github.com/sqlitebrowser/sqlitebrowser"
    "https://github.com/realm/SwiftLint"
    "https://github.com/facebook/hhvm"
    "https://github.com/uikit/uikit"
    "https://github.com/dotnet/corefx"
    "https://github.com/radareorg/radare2"
    "https://github.com/swoole/swoole-src"
    "https://github.com/microsoft/AI-For-Beginners"
    "https://github.com/mysqljs/mysql"
    "https://github.com/buger/goreplay"
    "https://github.com/tensorflow/tfjs"
    "https://github.com/chriskiehl/Gooey"
    "https://github.com/iovisor/bcc"
    "https://github.com/reduxjs/redux-thunk"
    "https://github.com/alibaba/ice"
    "https://github.com/handsontable/handsontable"
    "https://github.com/chaozh/awesome-blockchain-cn"
    "https://github.com/airyland/vux"
    "https://github.com/dianping/cat"
    "https://github.com/TheAlgorithms/Rust"
    "https://github.com/sharkdp/hyperfine"
    "https://github.com/sindresorhus/quick-look-plugins"
    "https://github.com/basecamp/trix"
    "https://github.com/inancgumus/learngo"
    "https://github.com/gentilkiwi/mimikatz"
    "https://github.com/zulip/zulip"
    "https://github.com/seaweedfs/seaweedfs"
    "https://github.com/lin-xin/vue-manage-system"
    "https://github.com/microsoft/MS-DOS"
    "https://github.com/motdotla/dotenv"
    "https://github.com/ssloy/tinyrenderer"
    "https://github.com/JacksonTian/fks"
    "https://github.com/npm/npm"
    "https://github.com/forezp/SpringCloudLearning"
    "https://github.com/microsoft/CNTK"
    "https://github.com/fengdu78/lihang-code"
    "https://github.com/facebookarchive/flux"
    "https://github.com/bokeh/bokeh"
    "https://github.com/koekeishiya/yabai"
    "https://github.com/lewagon/dotfiles"
    "https://github.com/sunface/rust-course"
    "https://github.com/Nyr/openvpn-install"
    "https://github.com/gabime/spdlog"
    "https://github.com/amark/gun"
    "https://github.com/tc39/proposals"
    "https://github.com/huggingface/datasets"
    "https://github.com/knex/knex"
    "https://github.com/ossu/data-science"
    "https://github.com/WordPress/WordPress"
    "https://github.com/julianshapiro/velocity"
    "https://github.com/dropzone/dropzone"
    "https://github.com/containers/podman"
    "https://github.com/google/dagger"
    "https://github.com/vim-airline/vim-airline"
    "https://github.com/BoostIO/BoostNote-Legacy"
    "https://github.com/flutter/plugins"
    "https://github.com/matplotlib/matplotlib"
    "https://github.com/ionic-team/ionicons"
    "https://github.com/reactnativecn/react-native-guide"
    "https://github.com/Shopify/draggable"
    "https://github.com/521xueweihan/GitHub520"
    "https://github.com/haoel/leetcode"
    "https://github.com/youzan/vant-weapp"
    "https://github.com/TheAlgorithms/C"
    "https://github.com/facebook/prophet"
    "https://github.com/facebook/fresco"
    "https://github.com/cocos2d/cocos2d-x"
    "https://github.com/statsd/statsd"
    "https://github.com/aFarkas/lazysizes"
    "https://github.com/jtoy/awesome-tensorflow"
    "https://github.com/less/less.js"
    "https://github.com/Tencent/mars"
    "https://github.com/JedWatson/classnames"
    "https://github.com/Tencent/tinker"
    "https://github.com/joewalnes/websocketd"
    "https://github.com/nfl/react-helmet"
    "https://github.com/spotify/luigi"
    "https://github.com/google/fonts"
    "https://github.com/matryer/xbar"
    "https://github.com/antonmedv/fx"
    "https://github.com/NVIDIA/nvidia-docker"
    "https://github.com/defunkt/jquery-pjax"
    "https://github.com/jarun/nnn"
    "https://github.com/exelban/stats"
    "https://github.com/css-modules/css-modules"
    "https://github.com/localtunnel/localtunnel"
    "https://github.com/facebookresearch/audiocraft"
    "https://github.com/prisma/prisma1"
    "https://github.com/appium/appium"
    "https://github.com/angular/material"
    "https://github.com/hzlzh/Best-App"
    "https://github.com/wbkd/react-flow"
    "https://github.com/fengdu78/deeplearning_ai_books"
    "https://github.com/AdguardTeam/AdGuardHome"
    "https://github.com/python/mypy"
    "https://github.com/jamiebuilds/react-loadable"
    "https://github.com/ElemeFE/mint-ui"
    "https://github.com/getlantern/download"
    "https://github.com/twitter/typeahead.js"
    "https://github.com/alsotang/node-lessons"
    "https://github.com/be5invis/Iosevka"
    "https://github.com/kovidgoyal/calibre"
    "https://github.com/facebook/yoga"
    "https://github.com/shuzheng/zheng"
    "https://github.com/fmtlib/fmt"
    "https://github.com/microsoft/fluentui"
    "https://github.com/tj/git-extras"
    "https://github.com/redis/node-redis"
    "https://github.com/hubotio/hubot"
    "https://github.com/jashkenas/coffeescript"
    "https://github.com/auth0/node-jsonwebtoken"
    "https://github.com/winterbe/java8-tutorial"
    "https://github.com/quozd/awesome-dotnet"
    "https://github.com/node-red/node-red"
    "https://github.com/karpathy/minGPT"
    "https://github.com/jantic/DeOldify"
    "https://github.com/google/filament"
    "https://github.com/Olshansk/interview"
    "https://github.com/instillai/TensorFlow-Course"
    "https://github.com/so-fancy/diff-so-fancy"
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
    sleep 10
done

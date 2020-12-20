# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/aayush/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
ZSH_DISABLE_COMPFIX="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias zshconf='vim ~/.zshrc'
alias tm='tmux attach || tmux new'
alias vim='nvim'
alias ls='exa'
alias ll='exa -l'
alias gst='git status'
alias z='zathura'
alias gworker="$HOME/go/src/github.com/cockroachdb/cockroach/scripts/gceworker.sh ssh"
alias gstop="$HOME/go/src/github.com/cockroachdb/cockroach/scripts/gceworker.sh stop"
alias ww="ssh aayush-desktop.local -A"
alias gstart="$HOME/go/src/github.com/cockroachdb/cockroach/scripts/gceworker.sh start"
alias view='gh pr view --web'
alias issue='gh issue view --web'
alias mp='mosh aayush@pop-os.local'
alias status='gh pr status'

export GOROOT="$(brew --prefix go)/libexec"

unalias gr
function gr() {
	if [ "$1" != "" ]
	then
		git rebase -i HEAD~"$1"
	fi
}

function newCluster() {
	if [ -z "$2" ]
	then
	else
		make bin/roachprod && roachprod create aayushs-test --nodes=$1 --lifetime=3h --gce-machine-type=n1-standard-$2;
	fi
}
alias gs=gsync
alias wee="rsync -avzP --update --exclude '(*.pb.go)|(*.js)' -e ssh /Users/aayush/go/src/github.com/cockroachdb/cockroach/pkg pop:/home/aayush/go/src/github.com/cockroachdb/cockroach/"
alias wendor="rsync -avzP --update -e ssh /Users/aayush/go/src/github.com/cockroachdb/cockroach/vendor pop:/home/aayush/go/src/github.com/cockroachdb/cockroach/"
alias goall="rsync -avzP --update -e ssh /Users/aayush/go/src/github.com/cockroachdb/cockroach aayush@pop-os.local:/home/aayush/go/src/github.com/cockroachdb/"

function wer() {
	if [ "$1" != "" ]
	then
		wee; ssh pop -Y "source /home/aayush/.zshrc; cd /home/aayush/go/src/github.com/cockroachdb/cockroach; $*"
	fi
}

function cp_file() {
	scp aayush@pop-os.local:/home/aayush/go/src/github.com/cockroachdb/cockroach/$1 .
}

function cp_lbin() {
	cp_file cockroach-linux-2.6.32-gnu-amd64
}

function lbuild() {
	wer "./build/builder.sh mkrelease amd64-linux-gnu" && cp_lbin;

}

function mbuild() {
	wer ./build/builder.sh mkrelease amd64-darwin && cp_file cockroach-darwin-10.10-amd64 && mv cockroach-darwin-10.10-amd64 ./cockroach

}

function mbuildshort() {
	wer ./build/builder.sh mkrelease amd64-darwin buildshort && cp_file cockroach-darwin-10.10-amd64 && mv cockroach-darwin-10.10-amd64 ./cockroach

}

function lbuildshort() {
	wer ./build/builder.sh mkrelease amd64-linux-gnu buildshort;

}

function lworkload() {
	wer ./build/builder.sh mkrelease amd64-linux-gnu bin/workload;
}

function lroachtest() {
	wer ./build/builder.sh mkrelease amd64-linux-gnu bin/roachtest;
}

function lroachprod() {
	wer make bin/roachprod;
}

function lclean() {
	wer make clean;
}

function lrrt() {
	wer make bin/roachtest && wer roachtest "$*";
}

export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"

func log_in_journal() {
	if [ "$1" != "" ]
	then
		mkdir -p ~/journal/$(date +"Week_%U_in_%b")
		echo "[$(date)]: $@" >> ~/journal/$(date +"Week_%U_in_%b")/$(date +"%A")
	fi
}

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$PATH:/usr/local/Cellar/go\@1.14/1.14.4/bin/"

PATH="/Users/aayush/go/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/aayush/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/aayush/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/aayush/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/aayush/google-cloud-sdk/completion.zsh.inc'; fi
export CLUSTER=aayushs-stress

alias rec='log_in_journal'
alias today="f() { cat ~/journal/$(date +'Week_%U_in_%b')/$(date +'%A') }; f"
alias thisweek="f() { cat ~/journal/$(date +'Week_%U_in_%b')/* | less }; f"

source $(brew --prefix)/etc/bash_completion.d/bazel-complete.bash
export PATH="/usr/local/opt/ccache/libexec:$PATH"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#compdef _gh gh


function _gh {
  local -a commands

  _arguments -C \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:' \
    '--version[Show gh version]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "completion:Generate shell completion scripts"
      "config:Set and get gh settings"
      "credits:View project's credits"
      "gist:Create gists"
      "help:Help about any command"
      "issue:Create and view issues"
      "pr:Create, view, and checkout pull requests"
      "repo:Create, clone, fork, and view repositories"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  completion)
    _gh_completion
    ;;
  config)
    _gh_config
    ;;
  credits)
    _gh_credits
    ;;
  gist)
    _gh_gist
    ;;
  help)
    _gh_help
    ;;
  issue)
    _gh_issue
    ;;
  pr)
    _gh_pr
    ;;
  repo)
    _gh_repo
    ;;
  esac
}

function _gh_completion {
  _arguments \
    '(-s --shell)'{-s,--shell}'[Shell type: {bash|zsh|fish|powershell}]:' \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}


function _gh_config {
  local -a commands

  _arguments -C \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "get:Prints the value of a given configuration key"
      "set:Updates configuration with the value of a given key"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  get)
    _gh_config_get
    ;;
  set)
    _gh_config_set
    ;;
  esac
}

function _gh_config_get {
  _arguments \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_config_set {
  _arguments \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_credits {
  _arguments \
    '(-s --static)'{-s,--static}'[Print a static version of the credits]' \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}


function _gh_gist {
  local -a commands

  _arguments -C \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "create:Create a new gist"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  create)
    _gh_gist_create
    ;;
  esac
}

function _gh_gist_create {
  _arguments \
    '(-d --desc)'{-d,--desc}'[A description for this gist]:' \
    '(-p --public)'{-p,--public}'[When true, the gist will be public and available for anyone to see (default: private)]' \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_help {
  _arguments \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}


function _gh_issue {
  local -a commands

  _arguments -C \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "close:Close issue"
      "create:Create a new issue"
      "list:List and filter issues in this repository"
      "reopen:Reopen issue"
      "status:Show status of relevant issues"
      "view:View an issue"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  close)
    _gh_issue_close
    ;;
  create)
    _gh_issue_create
    ;;
  list)
    _gh_issue_list
    ;;
  reopen)
    _gh_issue_reopen
    ;;
  status)
    _gh_issue_status
    ;;
  view)
    _gh_issue_view
    ;;
  esac
}

function _gh_issue_close {
  _arguments \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_issue_create {
  _arguments \
    '(*-a *--assignee)'{\*-a,\*--assignee}'[Assign a person by their `login`]:' \
    '(-b --body)'{-b,--body}'[Supply a body. Will prompt for one otherwise.]:' \
    '(*-l *--label)'{\*-l,\*--label}'[Add a label by `name`]:' \
    '(-m --milestone)'{-m,--milestone}'[Add the issue to a milestone by `name`]:' \
    '(*-p *--project)'{\*-p,\*--project}'[Add the issue to a project by `name`]:' \
    '(-t --title)'{-t,--title}'[Supply a title. Will prompt for one otherwise.]:' \
    '(-w --web)'{-w,--web}'[Open the browser to create an issue]' \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_issue_list {
  _arguments \
    '(-a --assignee)'{-a,--assignee}'[Filter by assignee]:' \
    '(-A --author)'{-A,--author}'[Filter by author]:' \
    '(*-l *--label)'{\*-l,\*--label}'[Filter by label]:' \
    '(-L --limit)'{-L,--limit}'[Maximum number of issues to fetch]:' \
    '(-s --state)'{-s,--state}'[Filter by state: {open|closed|all}]:' \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_issue_reopen {
  _arguments \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_issue_status {
  _arguments \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_issue_view {
  _arguments \
    '(-w --web)'{-w,--web}'[Open an issue in the browser]' \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}


function _gh_pr {
  local -a commands

  _arguments -C \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "checkout:Check out a pull request in Git"
      "close:Close a pull request"
      "create:Create a pull request"
      "diff:View a pull request's changes."
      "list:List and filter pull requests in this repository"
      "merge:Merge a pull request"
      "ready:Make a pull request as ready for review"
      "reopen:Reopen a pull request"
      "review:Add a review to a pull request."
      "status:Show status of relevant pull requests"
      "view:View a pull request"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  checkout)
    _gh_pr_checkout
    ;;
  close)
    _gh_pr_close
    ;;
  create)
    _gh_pr_create
    ;;
  diff)
    _gh_pr_diff
    ;;
  list)
    _gh_pr_list
    ;;
  merge)
    _gh_pr_merge
    ;;
  ready)
    _gh_pr_ready
    ;;
  reopen)
    _gh_pr_reopen
    ;;
  review)
    _gh_pr_review
    ;;
  status)
    _gh_pr_status
    ;;
  view)
    _gh_pr_view
    ;;
  esac
}

function _gh_pr_checkout {
  _arguments \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_pr_close {
  _arguments \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_pr_create {
  _arguments \
    '(*-a *--assignee)'{\*-a,\*--assignee}'[Assign a person by their `login`]:' \
    '(-B --base)'{-B,--base}'[The branch into which you want your code merged]:' \
    '(-b --body)'{-b,--body}'[Supply a body. Will prompt for one otherwise.]:' \
    '(-d --draft)'{-d,--draft}'[Mark pull request as a draft]' \
    '(-f --fill)'{-f,--fill}'[Do not prompt for title/body and just use commit info]' \
    '(*-l *--label)'{\*-l,\*--label}'[Add a label by `name`]:' \
    '(-m --milestone)'{-m,--milestone}'[Add the pull request to a milestone by `name`]:' \
    '(*-p *--project)'{\*-p,\*--project}'[Add the pull request to a project by `name`]:' \
    '(*-r *--reviewer)'{\*-r,\*--reviewer}'[Request a review from someone by their `login`]:' \
    '(-t --title)'{-t,--title}'[Supply a title. Will prompt for one otherwise.]:' \
    '(-w --web)'{-w,--web}'[Open the web browser to create a pull request]' \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_pr_diff {
  _arguments \
    '(-c --color)'{-c,--color}'[Whether or not to output color: {always|never|auto}]:' \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_pr_list {
  _arguments \
    '(-a --assignee)'{-a,--assignee}'[Filter by assignee]:' \
    '(-B --base)'{-B,--base}'[Filter by base branch]:' \
    '(*-l *--label)'{\*-l,\*--label}'[Filter by label]:' \
    '(-L --limit)'{-L,--limit}'[Maximum number of items to fetch]:' \
    '(-s --state)'{-s,--state}'[Filter by state: {open|closed|merged|all}]:' \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_pr_merge {
  _arguments \
    '(-d --delete-branch)'{-d,--delete-branch}'[Delete the local and remote branch after merge]' \
    '(-m --merge)'{-m,--merge}'[Merge the commits with the base branch]' \
    '(-r --rebase)'{-r,--rebase}'[Rebase the commits onto the base branch]' \
    '(-s --squash)'{-s,--squash}'[Squash the commits into one commit and merge it into the base branch]' \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_pr_ready {
  _arguments \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_pr_reopen {
  _arguments \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_pr_review {
  _arguments \
    '(-a --approve)'{-a,--approve}'[Approve pull request]' \
    '(-b --body)'{-b,--body}'[Specify the body of a review]:' \
    '(-c --comment)'{-c,--comment}'[Comment on a pull request]' \
    '(-r --request-changes)'{-r,--request-changes}'[Request changes on a pull request]' \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_pr_status {
  _arguments \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_pr_view {
  _arguments \
    '(-w --web)'{-w,--web}'[Open a pull request in the browser]' \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}


function _gh_repo {
  local -a commands

  _arguments -C \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "clone:Clone a repository locally"
      "create:Create a new repository"
      "fork:Create a fork of a repository"
      "view:View a repository"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  clone)
    _gh_repo_clone
    ;;
  create)
    _gh_repo_create
    ;;
  fork)
    _gh_repo_fork
    ;;
  view)
    _gh_repo_view
    ;;
  esac
}

function _gh_repo_clone {
  _arguments \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_repo_create {
  _arguments \
    '(-d --description)'{-d,--description}'[Description of repository]:' \
    '--enable-issues[Enable issues in the new repository]' \
    '--enable-wiki[Enable wiki in the new repository]' \
    '(-h --homepage)'{-h,--homepage}'[Repository home page URL]:' \
    '--public[Make the new repository public (default: private)]' \
    '(-t --team)'{-t,--team}'[The name of the organization team to be granted access]:' \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_repo_fork {
  _arguments \
    '--clone[Clone fork: {true|false|prompt}]' \
    '--remote[Add remote for fork: {true|false|prompt}]' \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}

function _gh_repo_view {
  _arguments \
    '(-w --web)'{-w,--web}'[Open a repository in the browser]' \
    '--help[Show help for command]' \
    '(-R --repo)'{-R,--repo}'[Select another repository using the `OWNER/REPO` format]:'
}


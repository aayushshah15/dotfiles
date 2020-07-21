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
plugins=(git)

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

unalias gr
function gr() {
	if [ "$1" != "" ]
	then
		git rebase -i HEAD~"$1"
	fi
}

alias gsync="rsync -avzP --update --exclude '*.js' -e ssh /Users/aayush/go/src/github.com/cockroachdb/cockroach/pkg gceworker:/home/aayush/go/src/github.com/cockroachdb/cockroach/"
alias gs=gsync
alias wee="rsync -avzP --update --exclude '(*.pb.go)|(*.js)' -e ssh /Users/aayush/go/src/github.com/cockroachdb/cockroach/pkg aayush@aayush-desktop.local:/home/aayush/go/src/github.com/cockroachdb/cockroach/"

alias goall="rsync -avzP --update -e ssh /Users/aayush/go/src/github.com/cockroachdb/cockroach aayush@aayush-desktop.local:/home/aayush/go/src/github.com/cockroachdb/cockroach"

func wer() {
	if [ "$1" != "" ]
	then
		wee; ssh aayush-desktop.local -X "source /home/aayush/.zshrc; cd /home/aayush/go/src/github.com/cockroachdb/cockroach; $1"
	fi
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
alias today="cat ~/journal/$(date +'Week_%U_in_%b')/$(date +'%A')"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

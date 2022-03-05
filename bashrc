# General .bashrc
if [ -f "/etc/skel/.bashrc" ]; then
	source /etc/skel/.bashrc
elif [ -f "/etc/bashrc" ]; then
	source /etc/bashrc
fi

# Locale
# Use "British" time for its 24-hour clock and week starting on Monday
export LC_TIME="en_GB.UTF-8"

# Ensure TZ is set to prevent glibc from making repetitive syscalls
# The zoom client does this, in particular.
# > It turns out that the localtime function in glibc will check if the TZ
# > environment variable is set. If it is not set (the two Ubuntus I’ve tested do
# > not set it), then glibc will use the stat system call every time localtime is
# > called. -- https://blog.packagecloud.io/eng/2017/02/21/set-environment-variable-save-thousands-of-system-calls/
export TZ=":/etc/localtime"

# Editor
if type vim &> /dev/null; then
	EDITOR=vim
elif type vi &> /dev/null; then
	EDITOR=vi
fi

# Prompt
function parse_git_branch()
{
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'
}

PS1="\u@\[\e[33m\]\h :: \[\e[1;34m\]\A :: \[\e[m\]\[\e[1;32m\]\w ::\[\e[m\]\[\e[0;35m\]\`parse_git_branch\`\[\e[00m\] \n$ "

# Paths
function prependpath() {
	[[ "$PATH" =~ "$1" ]] || PATH="${1}${PATH:+:${PATH}}"
}
# Start from nothing
unset PATH
# Export for commands that need to know PATH, e.g., /usr/bin/which
export PATH=""
# Add the standard paths
prependpath "/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin"

# Go
#prependpath "$HOME/.local/go/bin"
prependpath "$HOME/go/bin"

#export GO_VERSION="1.15.5"
#export GOPATH="$HOME/go"
#export GOBIN="$GOPATH/bin"
#export GOROOT="$GOPATH/$GO_VERSION"
#prependpath "$GOBIN"
#prependpath "$GOROOT/bin"

# Rust
prependpath "$HOME/.cargo/bin"

# Standard locations
prependpath "$HOME/.local/bin"
prependpath "/usr/local/bin"

# kubebuilder
alias kb=kubebuilder
# kubebuilder autocompletion
if [ ! -f ~/.local/share/kubebuilder-bash-completion ]; then
	mkdir -p ~/.local/share
	kubebuilder completion bash > ~/.local/share/kubebuilder-bash-completion
fi
. ~/.local/share/kubebuilder-bash-completion

# krew
export KREW_ROOT=$HOME/.krew
prependpath "$KREW_ROOT/bin"

# Bash options
shopt -s direxpand

# History
HISTSIZE=10000000
HISTFILESIZE=10000000
HISTTIMEFORMAT="%F %T "
HISTCONTROL=ignorespace:ignoredups:erasedups
shopt -s histappend histverify histreedit
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a"
# PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
# bind '"\e[A":history-search-backward' # UP searches using current input as prefix
# bind '"\e[B":history-search-forward'  # DOWN searches using current input as prefix

# Enable color for `ls`
export CLICOLOR=1

# Aliases
alias ls="ls --color=auto"
alias vi=vim
alias ag="ag --pager 'less -RFX'"
alias ll="ls -lha"
alias xo="xdg-open"

# ripgrep
lg()
{
	/usr/bin/rg -p "$@" | less -RFX
}

# Git Aliases
# alias g="git"
alias gst="git status"
alias gco="git checkout"
alias gbr="git branch"
alias gct="git commit"
alias grb="git rebase"
alias gdf="git diff"
alias glg="git log"
alias gpl="git pull"
alias gps="git push"
alias gad="git add"
alias grm="git rm"
alias gcp="git cherry-pick"
alias gre="git restore"

# Trash
alias rm="trash"

# Kubernetes
alias k=kubectl-v1.20.4
[ -f $HOME/.kube/completion.bash.inc ] && source $HOME/.kube/completion.bash.inc

# Helm
alias helm2init='kubectl --namespace kube-system create serviceaccount tiller && kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller && helm2 init --service-account tiller --wait'

# n (npm version manager)
export N_PREFIX=$HOME/.local

# fd
[ -f $HOME/.fd.bash ] && source $HOME/.fd.bash

# fzf
# keybindings when installed from dnf
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash
# keybindings when installed from source
[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash
[ -n "$TMUX_PANE" ] && FZF_TMUX=1
FZF_DEFAULT_COMMAND="fd --type file --color=always --hidden --follow --absolute-path --exclude .git"
FZF_ALT_C_COMMAND="fd --type directory --color=always --exclude .git"
FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
FZF_DEFAULT_OPTS="--ansi"
FZF_CTRL_R_OPTS=""

source $HOME/.bashrc.d2iq

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Complete all aliases
[ "$(type -t _complete_alias)" == "function" ] && complete -F _complete_alias $( alias | perl -lne 'print "$1" if /^alias ([^=]*)=/' )

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/dlipovetsky/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/home/dlipovetsky/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/dlipovetsky/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/home/dlipovetsky/Downloads/google-cloud-sdk/completion.bash.inc'; fi

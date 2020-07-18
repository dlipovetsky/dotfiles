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
export GO_VERSION="1.13.8"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export GOROOT="$GOPATH/$GO_VERSION"

prependpath "$GOBIN"
prependpath "$GOROOT/bin"

# Rust
prependpath "$HOME/.cargo/bin"

# Standard locations
prependpath "$HOME/.local/bin"
prependpath "/usr/local/bin"

# kubebuilder
ln --force --symbol "$HOME/.local/kubebuilder/bin/kubebuilder" "$HOME/.local/bin/kubebuilder"
# Expose kubebuilder in path, but hide the etcd, kube-apiserver, and kubectl
# binaries to avoid conflict
export KUBEBUILDER_ASSETS="$HOME/.local/kubebuilder/bin"
alias kb=kubebuilder

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
alias vi=vim
alias ag="ag --pager 'less -RFX'"
alias ll="ls -lha"

# ripgrep
lg()
{
	/usr/bin/rg -p "$@" | less -RFX
}

# Git Aliases
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
alias grs="git reset"

# Command completion for git aliases
if type -t "__git_complete" &>/dev/null; then
	__git_complete gco _git_checkout
	__git_complete gbr _git_branch
	__git_complete gct _git_commit
	__git_complete grb _git_rebase
	__git_complete gdf _git_diff
	__git_complete glg _git_log
	__git_complete gpl _git_pull
	__git_complete gps _git_push
	__git_complete gad _git_add
	__git_complete grm _git_rm
	__git_complete gcp _git_cherry_pick
fi

# Kubernetes
alias kc=kubectl
export KUBE_EDITOR=vim
[ -f $HOME/.kube/completion.bash.inc ] && source $HOME/.kube/completion.bash.inc

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

source $HOME/.d2iqrc

# General .bashrc
if [ -f "/etc/skel/.bashrc" ]; then
	source /etc/skel/.bashrc
elif [ -f "/etc/bashrc" ]; then
	source /etc/bashrc
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

# Go
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export GOROOT="$GOPATH/1.12.6"

prependpath "$GOBIN"
prependpath "$GOROOT/bin"

if [ -d "/usr/local/opt/python/libexec/bin" ]; then
	prependpath "/usr/local/opt/python/libexec/bin"
fi

prependpath "$HOME/bin"
prependpath "$HOME/.local/bin"
prependpath "/usr/local/bin"

# kubebuilder
prependpath "$HOME/.local/kubebuilder/bin"
export KUBEBUILDER_ASSETS="$HOME/.local/kubebuilder/bin"
alias kb=kubebuilder

# Bash options
shopt -s direxpand

# History
HISTSIZE=50000
HISTFILESIZE=50000
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
rg()
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

# n (npm version manager)
export N_PREFIX=$HOME/.local

# fd
[ -f ~/.fd.bash ] && source ~/.fd.bash

# fzf
# keybindings when installed from dnf
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash
# keybindings when installed from source
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -n "$TMUX_PANE" ] && FZF_TMUX=1
FZF_DEFAULT_COMMAND="fd --type file --color=always --hidden --follow --exclude .git"
FZF_ALT_C_COMMAND="fd --type directory --color=always --exclude .git"
FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
FZF_DEFAULT_OPTS="--ansi"


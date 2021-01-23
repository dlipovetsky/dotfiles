# ---------------------
# Misc.

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

# Enable color for `ls`
export CLICOLOR=1

# Allow '#' in interactive session
setopt interactive_comments

# Just type the dir name to cd to it
setopt autocd

# ---------------------
# History
HISTFILE=~/.history.zsh
HISTSIZE=1000000
SAVEHIST=10000000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

# ---------------------
# Completion
zstyle :compinstall filename '/home/dlipovetsky/.zshrc'
autoload -Uz compinit
compinit

# ---------------------
# Word movement
# (All possible characters) WORDCHARS='*?_.[]~&;!#$%^(){}<>-'

# First attempt
# WORDCHARS='-'
# autoload -U select-word-style
# select-word-style normal

WORDCHARS='*?_.[]~&;!#$%^(){}<>-'
autoload -U select-word-style
select-word-style normal

# ---------------------
# Keybindings

# emacs-style
bindkey -e

# ctrl+left/right to move cursor through words
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
# ctrl-up to kill word
bindkey "^[[1;5A" backward-kill-word
# ctrl-down to undo last change
bindkey "^[[1;5B" undo

# ---------------------
# Applications

# ripgrep
lg()
{
	/usr/bin/rg -p "$@" | less -RFX
}

# git
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

# ls
alias ls="ls --color"
alias ll="ls -l"

# kubectl
source /home/dlipovetsky/.config/zsh/completion/kubectl.zsh
alias k=kubectl
complete -F __start_kubectl k

# helmv3
source /home/dlipovetsky/.config/zsh/completion/helmv3.zsh

# fzf
# keybindings when installed from dnf
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh
# keybindings when installed from source
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
[ -n "$TMUX_PANE" ] && FZF_TMUX=1
FZF_DEFAULT_COMMAND="fd --type file --color=always --hidden --follow --absolute-path --exclude .git"
FZF_ALT_C_COMMAND="fd --type directory --color=always --exclude .git"
FZF_ALT_C_COMMAND=""
FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
FZF_DEFAULT_OPTS="--ansi"

# ---------------------
# Plugins

# zplug
# source ~/.zplug/init.zsh

# smart dir navigation
#zplug "b4b4r07/enhancd", from:github, use:init.sh

# autosuggestions
# zplug "zsh-users/zsh-autosuggestions", from:github

# prompt
# zplug mafredri/zsh-async, from:github
# zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
# zstyle :prompt:pure:path color black

# zplug load --verbose

# ---------------------
# D2IQ-specific things
source $HOME/.d2iqrc

# ---------------------
# Syntax Highlighting
# zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:2
# typeset -A ZSH_HIGHLIGHT_STYLES
# ZSH_HIGHLIGHT_STYLES[default]='none'
# ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
# ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,underline'
# ZSH_HIGHLIGHT_STYLES[global-alias]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,underline'
# ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
# ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=green,underline'
# ZSH_HIGHLIGHT_STYLES[path]='underline'
# ZSH_HIGHLIGHT_STYLES[path_pathseparator]=''
# ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=''
# ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[command-substitution]='none'
# ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=magenta'
# ZSH_HIGHLIGHT_STYLES[process-substitution]='none'
# ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=magenta'
# ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
# ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=magenta'
# ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[assign]='none'
# ZSH_HIGHLIGHT_STYLES[redirection]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[comment]='fg=black,bold'
# ZSH_HIGHLIGHT_STYLES[named-fd]='none'
# ZSH_HIGHLIGHT_STYLES[numeric-fd]='none'
# ZSH_HIGHLIGHT_STYLES[arg0]='fg=green,bold'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

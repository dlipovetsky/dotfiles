#!/usr/bin/env bash

# Global bashrc
if [ -f "/etc/bashrc" ]; then
	source /etc/bashrc
fi

# Bash options
shopt -s direxpand
# History
HISTSIZE=10000000
HISTFILESIZE=10000000
HISTTIMEFORMAT="%F %T "
HISTCONTROL=ignorespace:ignoredups:erasedups
shopt -s histappend histverify histreedit
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a"

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

# Default Editor
if command -v vim; then
	export EDITOR=vim
elif command -v vi; then
	export EDITOR=vi
fi

# Path
function prependpath() {
	[[ "$PATH" =~ "$1" ]] || PATH="${1}${PATH:+:${PATH}}"
}
# Start from nothing
unset PATH
# Set the standard paths
PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
# Make PATH available to shells created by processes, e.g., xargs
export PATH

# Source optional bashrc
for optional_rc in $HOME/.bashrc.*;
do
	source "$optional_rc"
done


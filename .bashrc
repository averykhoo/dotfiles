# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Source global definitions
[[ -f /etc/bashrc ]] && . /etc/bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [[ -z "${debian_chroot:-}" ]] && [[ -r /etc/debian_chroot ]]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# if previous printf/echo/cat/whatever didn't end with newline
# then print a red block (that's actually a space so it doesn't break copypasta) then newline
PROMPT_COMMAND='printf "\033[101m \033[0m%$((COLUMNS-1))s\\r"'

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [[ -n "$force_color_prompt" ]]; then
  if [[ -x /usr/bin/tput ]] && tput setaf 1 &>/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [[ "$color_prompt" == yes ]]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;

esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion
  fi
fi

# extend path to include local bin dirs, if they exist
[[ -d ~/bin ]] && export PATH=~/bin:$PATH
[[ -d ~/.local/bin ]] && export PATH=~/.local/bin:$PATH

# tell Python to use UTF-8 encoding for output to stdin, stdout, and stderr
export PYTHONIOENCODING="UTF-8"

# use UTF-8?
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# (nearly) unlimited bash history, for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=10000000

# concat multi-line commands into single line
shopt -s cmdhist

# append to the history file, don't overwrite it
shopt -s histappend

# unified bash history
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# recursive glob via '**' pattern which matches all files and zero or more directories and subdirectories
shopt -s globstar

# case insensitive glob
shopt -s nocaseglob

# try to fix typos when you cd to a folder
shopt -s cdspell

# you have to logout twice if there's a background job running
shopt -s checkjobs

# save multiline commands as single command
shopt -s cmdhist

# don't use vim
export EDITOR=nano

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable autojump
if [[ -f /usr/share/autojump/autojump.sh ]]; then
  source /usr/share/autojump/autojump.sh
fi

# enable conda (for bash) if it's not yet activated, and exists at one of the usual paths
# >>> conda init >>>
[[ ! -x "$(command -v conda)" ]] && [[ -f ~/anaconda3/bin/conda ]] && eval "$(~/anaconda3/bin/conda shell.bash hook)"
[[ ! -x "$(command -v conda)" ]] && [[ -f ~/anaconda/bin/conda ]] && eval "$(~/anaconda/bin/conda shell.bash hook)"
# <<< conda init <<<

# pre-populate fzf since we know exactly what script it wants
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# To anyone worried about using servers that may not have attentive admins --
# put the following line(s) in your ~/.bashrc to help protect yourself:
# It will print to stdout if and only if your shell is vulnerable, and nothing
# will be printed if your shell has been patched. It will take a little longer
# to launch a new shell slightly, but for some, this may be worth it.
env x='() { :;}; echo "WARNING: SHELLSHOCK DETECTED"' \
bash --norc -c ':' 2>/dev/null

# disables tldr updates; you can safely comment this out if you're online
export TLDR_EXPIRY=9999

# enable powerline
enable-powerline

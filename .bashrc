
# (nearly) unlimited bash history
HISTFILESIZE=10000000
HISTSIZE=1000000

# concat multi-line commands into single line
shopt -s cmdhist

# unified bash history
shopt -s histappend
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# If set, the pattern "**" used in a pathname expansion context
# will match all files and zero or more directories and subdirectories.
shopt -s globstar

# case insensitive glob
shopt -s nocaseglob

# try to fix typos when you cd to a folder
shopt -s cdspell

# you have to logout twice if there's a background job running
shopt -s checkjobs

# don't use stupid vim
export EDITOR=nano

# for exa
alias ll="exa -abghl"

# colorize less
alias less="less -R"

# colorize grep and stuff
alias grep='grep --color=always'
alias rg='rg --color=always'
alias ls='ls --color=always'
alias egrep='egrep --color=always'
alias fgrep='fgrep --color=always'
alias dir='dir --color=always'

# delete to trash
alias delete="mv -t ~/.Trash/"
alias del="mv -t ~/.Trash/"

# use prettyping
alias ping="prettyping"
alias ping2="/bin/ping"

# use fd
alias find="fd --color=always"
alias find2="/usr/bin/find"

# use pydf
alias df="pydf"
alias df2="/bin/df"

# use bat
alias more=bat

# windows compat
alias ipconfig="echo ASSUMING YOU MEAN IFCONFIG; ifconfig"
alias cls="echo ASSUMING YOU MEAN CLEAR; clear"
alias where="echo ASSUMING YOU MEAN WHICH; which"

# typos
alias dc="echo ASSUMING YOU MEAN CD; cd"
alias cd..="cd .."
alias cd-="cd -"

# stupid enterprise firewall
alias curl="curl --insecure"
alias wget="wget --no-check-certificate"
alias chrome="google-chrome --ignore-certificate-errors"

# convenience aliases
alias pycharm=charm
alias ..="cd .."

# auto-reload bashrc
alias bashrc="sudo nano ~/.bashrc && source ~/.bashrc"

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# enable powerline
#if [[ -f /usr/share/powerline/bindings/bash/powerline.sh ]]; then
#    powerline-daemon -q
#    POWERLINE_BASH_CONTINUATION=1
#    POWERLINE_BASH_SELECT=1
#    source /usr/share/powerline/bindings/bash/powerline.sh
#fi

# should be added by fzf, no need to manually add
#[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
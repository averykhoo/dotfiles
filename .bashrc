
# tell Python to use UTF-8 encoding for output to stdin, stdout, and stderr
export PYTHONIOENCODING="UTF-8"

# use UTF-8?
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

# (nearly) unlimited bash history
HISTFILESIZE=10000000
HISTSIZE=1000000

# concat multi-line commands into single line
shopt -s cmdhist

# unified bash history
shopt -s histappend
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

# don't use stupid vim
export EDITOR=nano

# More informative commands
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

# always make full path
alias mkdir='mkdir -p -v'

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

# use exa
if [[ -x "$(command -v exa)" ]]; then
    alias ll="exa -abghl"
    alias tree="exa -abghl --tree"
else
    alias ll="ls -Glah"
    alias tree="tree -L 1 --dirsfirst -shugp"
fi

# use prettyping
if [[ -x "$(command -v prettyping)" ]]; then
    alias ping="prettyping"
    alias ping2="/bin/ping"
fi

# use fd
if [[ -x "$(command -v fd)" ]]; then
    alias find="fd --color=always"
    alias find2="/usr/bin/find"
fi

# use pydf
if [[ -x "$(command -v pydf)" ]]; then
    alias df="pydf"
    alias df2="/bin/df"
fi

# use ad
if [[ -x "$(command -v ad)" ]]; then
    alias touch=ad
fi

# use bat
if [[ -x "$(command -v bat)" ]]; then
    alias more=bat
fi

# windows compat
alias ipconfig="echo ASSUMING YOU MEAN ifconfig; ifconfig"
alias cls="echo ASSUMING YOU MEAN clear; clear"
alias where="echo ASSUMING YOU MEAN which; which"

# typos
alias dc="echo ASSUMING YOU MEAN cd; cd"
alias cd..="cd .."
alias cd-="cd -"
alias \$="echo IGNORING LEADING '$'; "

# stupid enterprise firewall
alias curl="curl --insecure"
alias http="http --verify=no"
alias wget="wget --no-check-certificate"
alias chrome="google-chrome --ignore-certificate-errors"

# lazy cd (alternatively turn on shopt autocd)
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"  # `cd` is probably faster to type though
alias -- -="cd -"

# convenience aliases
alias apt="sudo apt"
alias yum="sudo yum"

# Repeat the last command with sudo prefixed
alias please='sudo $(fc -ln -1)'

# Open with default application
if [[ -x "$(command -v xdg-open)" ]]; then
    alias open='xdg-open'
fi

# auto-reload bashrc
alias bashrc="sudo nano ~/.bashrc && source ~/.bashrc"

# external ip (requires internet)
if [[ -x "$(command -v http)" ]]; then
    alias ip="http ifconfig.co/json"
else
    alias ip="curl https://ifconfig.co"
fi

# weather (requires internet)
alias weather="curl v2.wttr.in/singapore"

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

# maybe useful emoji?
# 😃 🍕 🍔 ⚓ ☠  ♠️ ♣️ ♥️ ♦️ ⚜ 💊 ☠ 💎 ⛵️ 🐓 🔥 💥 👉 💩 🌎 🍍 🛡 💡 ✏️ 💾 ⚙ ☢ 🌀 🌐 ▶️ ➡️ 🀄️ 🔴 🔵

# Create a data URL from a file
function dataurl() {
	local mimeType=$(file -b --mime-type "$1");
	if [[ ${mimeType} == text/* ]]; then
		mimeType="${mimeType};charset=utf-8";
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:-8000}";
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

# URL-encode strings
if [[ -x "$(command -v python)" ]]; then
    alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
fi
## Enable programmable completion features (you don't need to enable
## this, if it's already enabled in /etc/bash.bashrc and /etc/profile
## sources /etc/bash.bashrc).
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi


# alias xclip to systemwide clipboard if installed
if [[ -x "$(command -v xclip)" ]]; then
    alias shrug="echo '¯\_(ツ)_/¯' | xclip -selection clipboard"
	# copy to clipboard. ex: cat file1 | toclip
	alias toclip='xclip -selection clipboard'
	# paste from clipboard. ex: fromclip > file1 OR fromclip | cat
	alias fromclip='xclip -o -selection clipboard'
fi

#### GIT COMPLETION ###
## curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
#if [ -f ~/.git-completion.bash ]; then
#  . ~/.git-completion.bash
#fi

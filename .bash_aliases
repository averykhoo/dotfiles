
# some (ubuntu default) ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Ubuntu's "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
[[ -x "$(command -v notify-send)" ]] && alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# More informative commands
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

# prompt before overwrite
alias tar='tar -k -v'

# always make full path
alias mkdir='mkdir -p -v'

# colorize less
alias less="less -R"

# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias grep='grep --color=always'
    alias rg='rg --color=always'
    alias ls='ls --color=always'
    alias egrep='egrep --color=always'
    alias fgrep='fgrep --color=always'
    alias dir='dir --color=always'
    #alias vdir='vdir --color=auto'
fi

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

# ping -> prettyping
[[ -x "$(command -v prettyping)" ]] && alias ping="prettyping"

# find -> fd
[[ -x "$(command -v fd)" ]] && alias find="fd --color=always"

# df -> pydf
[[ -x "$(command -v pydf)" ]] && alias df="pydf"

# touch -> ad
[[ -x "$(command -v ad)" ]] && alias touch=ad

# more -> bat
[[ -x "$(command -v bat)" ]] && alias more=bat

# windows compat
[[ -x "$(command -v ifconfig)" ]] && alias ipconfig="echo ASSUMING YOU MEAN ifconfig; ifconfig"
[[ -x "$(command -v clear)" ]] && alias cls="echo ASSUMING YOU MEAN clear; clear"
[[ -x "$(command -v which)" ]] && alias where="echo ASSUMING YOU MEAN which; which"
[[ -x "$(command -v traceroute)" ]] && alias tracert="echo ASSUMING YOU MEAN traceroute; traceroute"

# typos
alias dc="echo ASSUMING YOU MEAN cd; cd"
alias cd..="cd .."
alias cd-="cd -"

# stupid enterprise firewall
[[ -x "$(command -v apt)" ]] && alias apt-get="sudo apt-get --allow-unauthenticated"
[[ -x "$(command -v curl)" ]] && alias curl="curl --insecure"
[[ -x "$(command -v http)" ]] && alias http="http --verify=no"
[[ -x "$(command -v wget)" ]] && alias wget="wget --no-check-certificate"
[[ -x "$(command -v google-chrome)" ]] && alias chrome="google-chrome --ignore-certificate-errors"
export GIT_SSL_NO_VERIFY=true



# lazy cd (alternatively turn on shopt autocd)
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"  # `cd` is probably faster to type though
alias -- -="cd -"

# sudo the things that need to be sudo
[[ -x "$(command -v apt)" ]] && alias apt="sudo apt"
[[ -x "$(command -v yum)" ]] && alias yum="sudo yum"
[[ -x "$(command -v snap)" ]] && alias snap="sudo snap"
[[ -x "$(command -v systemctl)" ]] && alias systemctl="sudo systemctl"
[[ -x "$(command -v subscription-manager)" ]] && alias subscription-manager="sudo subscription-manager"
[[ -x "$(command -v shutdown)" ]] && alias shutdown="sudo shutdown"
[[ -x "$(command -v reboot)" ]] && alias reboot="sudo reboot"

# Repeat the last command with sudo prefixed
# equivalent to `sudo !!`
alias please='sudo $(fc -ln -1)'
alias pls='sudo $(fc -ln -1)'

# Open with default application
[[ -x "$(command -v xdg-open)" ]] && alias open='xdg-open'

# auto-reload bashrc
alias bashrc="sudo nano ~/.bashrc && source ~/.bashrc"

# external ip (requires internet)
if [[ -x "$(command -v http)" ]]; then
    alias ipext="http ifconfig.co/json"
else
    alias ipext="curl https://ifconfig.co"
fi

# weather (requires internet)
alias weather="curl v2.wttr.in/singapore"

# shitty dos2unix
function fix-crlf () {
    if [[ $# -eq 0 ]]; then
        echo "Usage: $0 <filename or glob pattern>>"
#        grep --color=never -r -I -l $'\r' | xargs sed -i $'s/\\\r$//g'
#        grep --color=never -r -I -l $'\r' | xargs sed -i $'s/\\\r/\\\n/g'

    # is a file, just process that file
    elif [[ -f "$1" ]]; then
        grep --color=never -I -l $'\r' "$1" | xargs sed -i $'s/\\\r$//g'
        grep --color=never -I -l $'\r' "$1" | xargs sed -i $'s/\\\r/\\\n/g'

    # is a directory, process everything in that directory
    elif [[ -d "$1" ]]; then
        grep --color=never -r -I -l $'\r' "$1" | xargs sed -i $'s/\\\r$//g'
        grep --color=never -r -I -l $'\r' "$1" | xargs sed -i $'s/\\\r/\\\n/g'

    # is a pattern i guess
    else
        grep --color=never -r -I -l --include="$1" $'\r' . | xargs sed -i $'s/\\\r$//g'
        grep --color=never -r -I -l --include="$1" $'\r' . | xargs sed -i $'s/\\\r/\\\n/g'
    fi
}
[[ ! -x "$(command -v dos2unix)" ]] && alias dos2unix fixcrlf

# Create a data URL from a file
function dataurl () {
	local mimeType=$(file -b --mime-type "$1");
	if [[ ${mimeType} == text/* ]]; then
		mimeType="${mimeType};charset=utf-8";
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

## Start an HTTP server from a directory, optionally specifying the port
#function server() {
#	local port="${1:-8000}";
#	sleep 1 && open "http://localhost:${port}/" &
#	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
#	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
#	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
#}

## URL-encode strings
#if [[ -x "$(command -v python)" ]]; then
#    alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
#fi

# alias xclip to systemwide clipboard if installed
if [[ -x "$(command -v xclip)" ]]; then
    alias shrug="echo '¯\_(ツ)_/¯' | xclip -selection clipboard"
	# copy to clipboard. ex: cat file1 | toclip
	alias toclip='xclip -selection clipboard'
	# paste from clipboard. ex: fromclip > file1 OR fromclip | cat
	alias fromclip='xclip -o -selection clipboard'
fi

# Downloads the embedded video on any web page straight to the desktop.
[[ -x "$(command -v youtube-dl)" ]] && alias ytdl="cd ~/Downloads && youtube-dl \"$1\""

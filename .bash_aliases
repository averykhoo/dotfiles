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
  if [[ -r ~/.dircolors ]]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi

  [[ -x "$(command -v grep)" ]] && alias grep='grep --color=auto'
  [[ -x "$(command -v rg)" ]] && alias rg='rg --color=auto'
  [[ -x "$(command -v ls)" ]] && alias ls='ls --color=auto'
  [[ -x "$(command -v egrep)" ]] && alias egrep='egrep --color=auto'
  [[ -x "$(command -v fgrep)" ]] && alias fgrep='fgrep --color=auto'
  [[ -x "$(command -v dir)" ]] && alias dir='dir --color=auto'
  [[ -x "$(command -v vdir)" ]] && alias vdir='vdir --color=auto'
  [[ -x "$(command -v fd)" ]] && alias find="fd --color=auto"
fi

# delete to trash
alias delete="mkdir ~/.Trash/; mv -t ~/.Trash/"
alias del="mkdir ~/.Trash/; mv -t ~/.Trash/"

## kill everything with this name
## just use pkill -f <command-name>
#alias hose kill -9 '`ps -augxww | grep \!* | awk \'{print $2}\'`'

# use exa for ll
if [[ -x "$(command -v exa)" ]]; then
  alias ll="exa -abghl --color-scale --git --group-directories-first"
else
  alias ll="ls -lAh"
fi

# use exa for tree
if [[ -x "$(command -v exa)" ]]; then
  alias tree="exa -abghl --tree"
elif [[ -x "$(command -v tree)" ]]; then
  alias tree="tree -L 3 --dirsfirst -shugp"
else
  alias tree="ls -lAhR"
fi

# ping -> prettyping
[[ -x "$(command -v prettyping)" ]] && alias ping="prettyping"

## df -> pydf
#[[ -x "$(command -v pydf)" ]] && alias df="pydf"

# df -> duf
[[ -x "$(command -v duf)" ]] && alias df="duf"

# touch -> ad
[[ -x "$(command -v ad)" ]] && alias touch=ad

# more -> bat
[[ -x "$(command -v bat)" ]] && alias more=bat
[[ ! -x "$(command -v bat)" ]] && alias more=more_with_filename_and_lineno

# rm -> safe-rm
[[ -x "$(command -v safe-rm)" ]] && alias rm=safe-rm

# windows compat
[[ -x "$(command -v ifconfig)" ]] && alias ipconfig="echo ASSUMING YOU MEAN 'ifconfig' 1>&2; ifconfig"
[[ -x "$(command -v clear)" ]] && alias cls="echo ASSUMING YOU MEAN 'clear' 1>&2; clear"
[[ -x "$(command -v traceroute)" ]] && alias tracert="echo ASSUMING YOU MEAN 'traceroute' 1>&2; traceroute"
alias where="echo ASSUMING YOU MEAN 'type -a' 1>&2; type -a"

# typos
alias dc="echo ASSUMING YOU MEAN 'cd' 1>&2; cd"
[[ -x "$(command -v timedatectl)" ]] && [[ ! -x "$(command -v datetimectl)" ]] && alias datetimectl="echo ASSUMING YOU MEAN 'timedatectl' 1>&2; timedatectl"
alias cd..="cd .."
alias cd-="cd -"
alias sudosu="sudo su"

# compatibility with stupid enterprise firewall
[[ -x "$(command -v apt)" ]] && alias apt="sudo apt --allow-unauthenticated"
[[ -x "$(command -v curl)" ]] && alias curl="curl --insecure"
[[ -x "$(command -v http)" ]] && alias http="http --verify=no"
[[ -x "$(command -v wget)" ]] && alias wget="wget --no-check-certificate"
[[ -x "$(command -v google-chrome)" ]] && alias chrome="google-chrome --ignore-certificate-errors"
[[ -x "$(command -v pip)" ]] && alias pip="pip --trusted-host pypi.org --trusted-host files.pythonhosted.org"
[[ -x "$(command -v git)" ]] && git config --global http.sslVerify false
[[ -x "$(command -v git)" ]] && git config --global url."https://".insteadOf git://
export GIT_SSL_NO_VERIFY=true

# launch kite
[[ -x ~/.local/share/kite/kited ]] && alias kite=~/.local/share/kite/kited
[[ -x ~/.local/share/kite/kited ]] && alias kited=~/.local/share/kite/kited

# lazy cd (alternatively turn on shopt autocd)
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# allow aliases to be run via sudo
alias sudo='sudo '

# sudo the things that need to be run as sudo
[[ -x "$(command -v usermod)" ]] && alias usermod="sudo usermod"
# [[ -x "$(command -v apt)" ]] && alias apt="sudo apt"  # see above firewall-compatibility alias
[[ -x "$(command -v gdebi)" ]] && alias gdebi="sudo gdebi"
[[ -x "$(command -v yum)" ]] && alias yum="sudo yum"
[[ -x "$(command -v snap)" ]] && alias snap="sudo snap"
[[ -x "$(command -v systemctl)" ]] && alias systemctl="sudo systemctl"
[[ -x "$(command -v subscription-manager)" ]] && alias subscription-manager="sudo subscription-manager"
[[ -x "$(command -v shutdown)" ]] && alias shutdown="sudo shutdown"
[[ -x "$(command -v reboot)" ]] && alias reboot="sudo reboot"
[[ -x "$(command -v iftop)" ]] && alias iftop="sudo iftop"
[[ -x "$(command -v nethogs)" ]] && alias nethogs="sudo nethogs"
[[ -x "$(command -v kubeadm)" ]] && alias kubeadm="sudo kubeadm"
[[ -x "$(command -v update-ca-certificates)" ]] && alias update-ca-certificates="sudo update-ca-certificates"
[[ -x "$(command -v add-apt-repository)" ]] && alias add-apt-repository="sudo add-apt-repository"

# # docker, if your user is not in docker group
# # but it's better to run `sudo usermod -aG docker $(whoami) && newgrp docker`
# [[ -x "$(command -v docker)" ]] && alias docker="sudo docker"
# [[ -x "$(command -v docker-compose)" ]] && alias docker-compose="sudo docker-compose"
# [[ -x "$(command -v dockercompose)" ]] && alias dockercompose="sudo docker-compose"

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
function fix-crlf() {

  # no args given
  if [[ $# -eq 0 ]]; then
    echo "Usage: ${FUNCNAME[0]} <filename or directory>"
    return 0

  # is a file, just process that file
  elif [[ -f "$1" ]]; then
    if grep -q -I -l $'\r' "$1"; then
      echo "Fixing: $1"
      sed -i $'s/\\\r$//g' "$1"
      grep -q -I -l $'\r' "$1" && sed -i $'s/\\\r/\\\n/g' "$1"
      return 0
    else
      echo "Nothing to fix (or binary file): $1"
      return 1
    fi

  # is a directory, process everything in that directory
  elif [[ -d "$1" ]]; then
    echo "Fixing (recursive): $1"
    grep --color=never -r -I -l $'\r' "$1" | xargs sed -i $'s/\\\r$//g'
    grep --color=never -r -I -l $'\r' "$1" | xargs sed -i $'s/\\\r/\\\n/g'
    return $?

  # is a pattern i guess
  else
    echo "Error: $1 does not exist"
    return 2
  fi
}
[[ ! -x "$(command -v dos2unix)" ]] && alias dos2unix="fix-crlf"

# Create a data URL from a file
function dataurl() {
  local mimeType
  mimeType=$(file -b --mime-type "$1")
  if [[ ${mimeType} == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

## Start an HTTP server from a directory, optionally specifying the port
#function server() {
#	local port="${1:-8000}";
#	sleep 1 && open "http://localhost:${port}/" &
#	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
#	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
#	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
#}

# python-based convenience functions
if [[ -x "$(command -v python)" ]]; then
  function urlencode() {
    python -c 'import sys, urllib as ul; print(ul.quote_plus(sys.stdin.read()))'
  }
  function urldecode() {
    python -c 'import sys, urllib as ul; print(ul.parse(sys.stdin.read()))'
  }

  function yaml_validate() {
    python -c 'import sys, yaml, json; yaml.safe_load(sys.stdin.read())'
  }

  function yaml2json() {
    python -c 'import sys, yaml, json; print(json.dumps(yaml.safe_load(sys.stdin.read())))'
  }

  function yaml2json_pretty() {
    python -c 'import sys, yaml, json; print(json.dumps(yaml.safe_load(sys.stdin.read()), indent=4, sort_keys=False))'
  }

  function json_validate() {
    python -c 'import sys, yaml, json; json.loads(sys.stdin.read())'
  }

  function json2yaml() {
    python -c 'import sys, yaml, json; print(yaml.dump(json.loads(sys.stdin.read())))'
  }
fi

## alias xclip to systemwide clipboard if installed
#if [[ -x "$(command -v xclip)" ]]; then
#    alias shrug="echo '¯\_(ツ)_/¯' | xclip -selection clipboard"
#	# copy to clipboard. ex: cat file1 | toclip
#	alias toclip='xclip -selection clipboard'
#	# paste from clipboard. ex: fromclip > file1 OR fromclip | cat
#	alias fromclip='xclip -o -selection clipboard'
#fi

## Downloads the embedded video on any web page straight to the desktop.
#[[ -x "$(command -v youtube-dl)" ]] && alias ytdl="cd ~/Downloads && youtube-dl \"$1\""

function quiet_helm() {
  helm $* 2>&1 | grep -v ": skipping loading invalid entry" # do not quote this $*
  return "${PIPESTATUS[0]}"
}

[[ -x "$(command -v helm)" ]] && alias helm="quiet_helm"

# extra handling for kubectl
if [[ -x "$(command -v kubectl)" ]]; then
  # enable kubecolor
  if [[ -x "$(command -v kubecolor)" ]]; then
    alias kubectl="kubecolor"
  fi

  # lastly setup completions and a shortcut
  kubectl completion bash >~/.local/share/bash-completion/kubectl-completion.bash
  alias k="kubectl"
  # based on https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-bash-linux/
  complete -o default -F __start_kubectl k
fi

# get the newest file in the current folder
function newest_file() {
  unset -v newest_file

  # take first arg if it exists, otherwise take current directory
  local dir="${1:-.}"

  # iterate over all files in the directory
  for file in "${dir}"/*; do
    [[ ${file} -nt ${newest_file} ]] && newest_file=${file}
  done

  echo "${newest_file}"
}

# get the oldest file in the current folder
function oldest_file() {
  unset -v oldest_file

  # take first arg if it exists, otherwise take current directory
  local dir="${1:-.}"

  # iterate over all files in the directory
  for file in "${dir}"/*; do
    [[ -z ${oldest_file} || $file -ot ${oldest_file} ]] && oldest_file=${file}
  done

  echo "${oldest_file}"
}

[[ ! -x "$(command -v oldest)" ]] && alias oldest="oldest_file"
[[ ! -x "$(command -v newest)" ]] && alias newest="newest_file"
[[ ! -x "$(command -v earliest)" ]] && alias earliest="oldest_file"
[[ ! -x "$(command -v latest)" ]] && alias latest="newest_file"

# enable powerline (assuming it was installed via pip3)
function enable-powerline() {
  if [[ -x "$(command -v pip3)" ]] && [[ -x "$(command -v powerline-daemon)" ]]; then

    # only enable if we're using SSH but not in the cockpit web shell
    if [[ ! $TERM == "linux" ]] && [[ ! $XDG_SESSION_TYPE == "web" ]]; then

      POWERLINE_ROOT=$(pip3 show powerline-status --disable-pip-version-check | grep -oP --color=never "(?<=Location: ).*")/powerline
      if [[ -f ${POWERLINE_ROOT}/bindings/bash/powerline.sh ]]; then
        if ! pgrep -f "powerline-daemon" >/dev/null; then
          powerline-daemon -q
        fi
        POWERLINE_BASH_CONTINUATION=1
        POWERLINE_BASH_SELECT=1
        source ${POWERLINE_ROOT}/bindings/bash/powerline.sh
      fi
      unset POWERLINE_ROOT
    fi
  fi
}

# _cut_negative() is a wrapper around the cut command that allows fields to be specified as negative numbers.
# for compatibility with cut's current syntax, negative numbers must be specified with "--\d".
#     e.g. `cut -f--1`  takes the last field
#     e.g. `cut -f---2` takes all fields from the start to the second-last
#     e.g. `cut -f--3-` takes the last 3 fields
# possible patterns for the -f argument are:
#     x, -x, x-       (counting from the front, supported)
#     --x, ---x, --x- (counting from the back, supported)
#     x-y             (range counting from the front only, supported)
#     --x-y           (range counting from the back and front, NOT SUPPORTED)
#     x---y           (range counting from the front and back, NOT SUPPORTED)
#     --x---y         (range counting from the back only, supported)
function _cut_negative() {
  if [[ $# -eq 0 ]]; then
    echo "Usage:"
    echo "    cut -f<fields>        [OPTIONS] <file>"
    echo "    cut --fields=<fields> [OPTIONS] <file>"
    echo "Wrapper around the 'cut' command that allows fields to be specified as negative numbers."
    echo "For compatibility with cut's current syntax, negative numbers must be specified with '--\d'."
    echo "Supported field patterns for the -f / --fields argument are:"
    echo "     x        -> return the x-th field"
    echo "     -x       -> return the first x fields"
    echo "     x-       -> return all fields from x-th to the last"
    echo "     --x      -> return the x-th field from the end"
    echo "     ---x     -> return all fields from the first to x-th from the end"
    echo "     --x-     -> return the last x fields"
    echo "     x-y      -> return the x-th field to the y-th field"
    echo "     --x---y  -> return the x-th field (from the end) to the y-th field (from the end)"
    echo "Examples:"
    echo "     echo 'some,csv,data,row' | cut -d',' -f1    # returns 'some'"
    echo "     echo 'some,csv,data,row' | cut -d',' -f--1  # returns 'row'"
    echo "     echo 'some,csv,data,row' | cut -d',' -f-2   # returns 'some,csv'"
    echo "     echo 'some,csv,data,row' | cut -d',' -f---2 # returns 'some,csv,data'"
    echo "     echo 'some,csv,data,row' | cut -d',' -f2-   # returns 'csv,data,row'"
    echo "     echo 'some,csv,data,row' | cut -d',' -f--2- # returns 'data,row'"
    return 1
  fi

  # init empty variable for the field argument
  field=

  # iterate over the arguments
  for arg in "$@"; do
    shift # shift the arguments to remove the current argument from the list

    # throw errors for unsupported args
    if [[ "$arg" =~ ^-f--[^-]+-[^-]+$ ]]; then
      field="${arg#-f--}" # remove the "-f" prefix
      first="${field%%-*}"
      second="${field##*-}"
      echo "unsupported argument for -f: range counting from back and front: $arg" 1>&2
      echo "try calling 'cut -f-${second} | cut -f--${first}-' instead" 1>&2
      exit 1 # todo: make this work
    elif [[ "$arg" =~ ^-f[^-]+---[^-]+$ ]]; then
      field="${arg#-f}" # remove the "-f" prefix
      first="${field%%---*}"
      second="${field##*---}"
      echo "unsupported argument for -f: range counting from front and back: $arg" 1>&2
      echo "try calling 'cut -f${first}- | cut -f---${second}' instead" 1>&2
      exit 1 # todo: make this work too

    # if an argument starting with "-f--" is found, the remainder of that argument is taken as the field number.
    # some processing is then done to reverse the range, since we're applying cut on the reversed string
    elif [[ "$arg" =~ ^-f-- ]]; then
      field="${arg#-f--}" # remove the "-f--" prefix

      # if the field number starts with a hyphen, move it to the end
      if [[ "$field" =~ ^- ]]; then
        field="${field#?}-"

      # if the field number ends with a hyphen, move it to the start
      elif [[ "$field" =~ -$ ]]; then
        field="-${field%?}"

      # if the field number looks like "x---y", then we can simply reverse the range
      # refer to https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
      elif [[ "$field" =~ ^[^-]+---[^-]+$ ]]; then
        field="${field##*---}-${field%%---*}"
      fi

      # add the modified field number back to the list of arguments
      set -- "$@" -f"$field"

    # arg doesn't start with "-f--" is found, so just put it back the same way we found it
    else
      set -- "$@" "$arg"
    fi
  done

  # if we found a negative field argument, we'll reverse, then cut, then reverse again
  if [ -n "$field" ]; then
    rev | cut "$@" | rev

  # otherwise, just call cut with the same arguments we received
  else
    cut "$@"
  fi

  # return the exit code from cut
  return $?
}

# since it's fully backwards compatible, just alias it
alias cut="_cut_negative"

function more_with_filename_and_lineno() {
  awk '{printf "\033[36m%s:%'"$((1 - $(wc -l <$1 | wc -c)))"'d | \033[0m%s\n", FILENAME, NR, $0}' $1 | more
}

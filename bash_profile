# Get the aliases and functions
if [ -f ~/.bashrc ]; then
         . ~/.bashrc
fi
#source .bashrc

function gpp {
	branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`;
	git pull origin $branch;
	git push origin $branch;
}

# Git tab completion
source ~/.git-completion.bash
# Show branch in status line

# PS1='[\W$(__git_ps1 " (%s)")]\$'
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'

# PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
# BASH_ENV=$HOME/.bashrc
# USERNAME=""
# export USERNAME BASH_ENV PATH
#export PATH

# script that colors git branch and shows time and current branch
RED="\033[0;31m"
YELLOW="\033[0;33m"
GREEN="\033[0;32m"
NO_COLOUR="\033[0m"

function parse_git_branch () {
   git status -b --porcelain 2> /dev/null | head -1 | sed -e 's/## //' -e 's/\.\.\..* \[/ \[/'
}

function parse_git_color () {
  if [ -n "`git status --porcelain 2>&1 | grep "fatal: Not a git repository"`" ]
  then
    echo -e "$NO_COLOUR"
  elif [ -z "`git status --porcelain 2> /dev/null`" ]
  then
    echo -e "$GREEN"
  elif [ -z "`git status --porcelain 2> /dev/null | grep -v -E "^[MARCD]  .*$"`" ]
  then
    echo -e "$YELLOW"
  else
    echo -e "$RED"
  fi
}

function parse_git_status () {
  if [ -n "`git status --porcelain 2>&1 | grep "fatal: Not a git repository"`" ]
  then
    echo -e ""
  elif [ -z "`git status --porcelain 2> /dev/null`" ]
  then
    echo -e "(`parse_git_branch`)"
  elif [ -z "`git status --porcelain 2> /dev/null | grep -v -E "^[MARCD]  .*$"`" ]
  then
    echo -e "{`parse_git_branch`}"
  else
    echo -e "<`parse_git_branch`>"
  fi
}

export PS1="\[$GREEN\]\t\[$NO_COLOUR\]:\w \[\$(parse_git_color)\]\$(parse_git_status)\[$NO_COLOUR\]\$ "

# Adding rvm to PATH

# Setting git and general editor to subl
export GIT_EDITOR="subl -w"
export EDITOR="subl -w"

# Aliases
function desktop {
  cd /Users/liouyang/Desktop/$@
}
function code {
  cd /Users/liouyang/Development/code/$@
}

function dev {
  cd /Users/liouyang/Development/$@
}

function sites {
  cd /Users/liouyang/Sites/$@
}
# extract anything
function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Adds autocomplete to commands
complete -o dirnames code

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

##
# Your previous /Users/liouyang/.bash_profile file was backed up as /Users/liouyang/.bash_profile.macports-saved_2012-12-23_at_15:53:51
##

# MacPorts Installer addition on 2012-12-23_at_15:53:51: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# echo 'Hi Li! Everyone @FlationSchool misses you!'
# say 'We miss you Li'

# Bash shortcuts
BASH_KEYS=$(cat <<EOF
Ctrl + A  Go to the beginning of the line you are currently typing on
Ctrl + E  Go to the end of the line you are currently typing on
Ctrl + L  Clears the Screen, similar to the clear command
Ctrl + U  Clears the line before the cursor position. If you are at the end of the line, clears the entire line.
Ctrl + H  Same as backspace
Ctrl + R  Let’s you search through previously used commands
Ctrl + C  Kill whatever you are running
Ctrl + D  Exit the current shell
Ctrl + Z  Puts whatever you are running into a suspended background process. fg restores it.
Ctrl + W  Delete the word before the cursor
Ctrl + K  Clear the line after the cursor
Ctrl + T  Swap the last two characters before the cursor
Esc + T  Swap the last two words before the cursor
Alt + F  Move cursor forward one word on the current line
Alt + B  Move cursor backward one word on the current line
Tab Auto-complete files and folder names
EOF
)

alias bh="echo '$BASH_KEYS'"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

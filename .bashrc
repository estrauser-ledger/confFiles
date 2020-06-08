# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lFh'
alias la='ls -Ah'
alias l='ls -CFh'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

function color_my_prompt {
    local __user_and_host="\[\033[00;39m\]\u:"
    local __cur_location="\[\033[00;94m\]\w"
    local __git_branch_color="\[\033[93m\]"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\/`'
    local __prompt_tail="\[\033[39m\]$"
    local __last_color="\[\033[00m\]"
    export PS1="$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}
color_my_prompt

export USER_HOME="/home/estrauser"
export JAVA_HOME="$USER_HOME/opt/jdk8"
export INSTALL4J_JAVA_HOME="$USER_HOME/opt/jre1.7.0"
export MAVEN_HOME="$USER_HOME/opt/maven"
export SBT_HOME="$USER_HOME/opt/sbt"
export MONGO_HOME="$USER_HOME/opt/mongodb"
export ROBOMONGO_HOME="$USER_HOME/opt/robomongo"
export ACTIVATOR_HOME="$USER_HOME/opt/activator"
export PHANTOMJS_HOME="$USER_HOME/opt/phantomjs"
export DOCKER_HOME="$USER_HOME/opt/docker"

export DOCKER_HOST="tcp://dockerbo.vidal.net:4243"

export PATH="$USER_HOME/bin:$DOCKER_HOME/bin:$PHANTOMJS_HOME/bin:$ACTIVATOR_HOME:$ROBOMONGO_HOME/bin:$USER_HOME/opt/DbVisualizer:$MONGO_HOME/bin:$SBT_HOME/bin:$MAVEN_HOME/bin:$JAVA_HOME/bin:$PATH"

alias gst="git status"
alias gco="git checkout"
alias gc="git commit"
alias gl="git log --oneline --graph --decorate --color -20"
#alias gl="git log --graph -20 --pretty=format:'%C(yellow)%h¤%Cred%ar¤%Cblue%an¤%Cgreen%d %Creset%s' | column -ts '¤'"
alias gl="git log --graph --oneline --decorate -n20"
alias gp="git pull"
alias ga="git add -p"
alias gb="git fetch && git branch && git branch --remote"

alias rg="ripgrep.rg"

alias scc="sbt clean compile"
alias sc="find . -name target -exec rm -r "{}" \;"

alias mci="mvn clean install"

alias mongo.="mongod --dbpath='.'"

export EDITOR=vim

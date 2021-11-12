# ---[ Environment ]-----------------------------------------------------
export EDITOR='vim -p'
#export EDITOR="emacsclient -t -a ''"
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH=/usr/local/bin:${HOME}/bin:/usr/local/sbin:/usr/sbin:/sbin:${PATH}
#export PYTHONPATH=${HOME}/.python:${PYTHONPATH}
#export PS_PERSONALITY='linux'
#export GREP_OPTIONS='--color=auto --exclude-dir=\.svn --exclude-dir=\.git'

# Manpath & Manualpage search order
export MANSECT=2:3:9:8:1:5:4:7:6:n

PAGER='less'
export GIT_PAGER='less'

export TERM='xterm'
if [[ -r ~/.dir_colors ]]; then
		eval `dircolors -b ~/.dir_colors`
elif [[ -r /etc/DIR_COLORS ]]; then
		eval `dircolors -b /etc/DIR_COLORS`
fi

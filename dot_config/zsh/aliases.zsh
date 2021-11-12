
# ---[ Alias Section ]-------------------------------------------------
alias vi=vim
alias e="$EDITOR"
alias c='clear'
alias s=sudo 
alias g='git'
alias -s pdf="evince" 
alias 6='s ip -6'
alias 4='s ip -4'
alias 0='s ip -0'
alias l='ls -CF'
alias p='ps -A f -o user,pid,priority,ni,pcpu,pmem,args'
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias nh='unset HISTFILE'
alias j=jobs
alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history
alias top=htop
alias ls="ls --color=auto" 
alias grep="grep --color=auto"
alias ll='ls -lh'
alias la='ls -a'
alias lla='ll -a'
# List only directories and symbolic
# links that point to directories
alias lsd='ls -ld *(-/DN)'
# List only file beginning with "."
alias lsa='ls -ld .*'
# web cat
alias wcat='wget -q -O -'
alias j=jump

# Global aliases -- These do not have to be
# at the beginning of the command line.
alias -g L='less'
alias -g M='more'
alias -g H='head'
alias -g T='tail'

alias k=kubectl
alias ks="kubectl --namespace kube-system"

alias sway='XKB_DEFAULT_LAYOUT=fr XKB_DEFAULT_VARIANT=bepo sway'

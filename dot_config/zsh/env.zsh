# ---[ Environment ]-----------------------------------------------------
export EDITOR='nvim'
export GOPATH=$HOME/.go
#
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


# Dell xps13 related evn var
export LIBVA_DRIVER_NAME=iHD

export MOZ_ENABLE_WAYLAND=1
export PATH=$PATH:/opt/shadow-tech/:$HOME/bin:$HOME/.cargo/bin:/usr/local/bin

export BELL_ADDRESS="https://bell.restanrm.fr"

# Work related env vars

{{- if .work }}
export VAULT_ADDR=https://vault.delivery.sekoia.io
export PULL_REGISTRY=registry.sekoia.io
export PUSH_REGISTRY=registry.sekoia.io
export RELEASE_ID=latest
export PLATFORM=dev
{{- end }}


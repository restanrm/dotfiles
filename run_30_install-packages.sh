#!/bin/bash

# install packages

{{- if eq .osRelease.id "alpine" }}

for pkg in ripgrep fzf httpie kubectl fd gopass; do
  apk add --no-cache $pkg
done

{{- else if eq .osRelease.id "arch" }}

sudo pacman -Sy --noconfirm ripgrep fzf httpie fd kubectl python-openstackclient gopass

{{- else if eq .osRelease.id "debian" }}

sudo apt install -y ripgrep fzf pip httpie kubernetes-client fd-find gopass
pip install openstackclient

{{- end }}

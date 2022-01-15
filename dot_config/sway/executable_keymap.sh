#!/usr/bin/env bash


function x() {
  LAYOUT=$(setxkbmap -print | grep bepo)

  if [ "${LAYOUT}" = "" ]; then
    setxkbmap fr bepo
  else
    setxkbmap fr
  fi
}

function wayland() {
  swaymsg -t get_inputs | grep -q BEPO
  res=$?
  echo "res: $res"
  if [[ ${res} -eq 0 ]]; then
    swaymsg input type:keyboard xkb_layout fr
  else
    swaymsg "input type:keyboard xkb_layout fr(bepo)"
  fi
}

if [ ! -z ${WAYLAND_DISPLAY} ]; then
  wayland
else
  x
fi

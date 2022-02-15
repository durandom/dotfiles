#!/usr/bin/env bash

EXCLUDE_PATHS=(
    "/usr/local/Cellar"
    "/Users/Shared"
    "/Users/mhild/Applications"
    "/Users/mhild/Music"
    "/Users/mhild/Downloads"
    "/Users/mhild/Movies"
    "/Users/mhild/phobos_old"
    "/Users/mhild/Applications"
    "/Users/mhild/Virtual Machines.localized"
    "/Users/mhild/Pictures"
    "/Users/mhild/src_old"
    "/Users/mhild/Public"
)

for p in "${EXCLUDE_PATHS[@]}"
do 
  sudo tmutil addexclusion -p "$p"
#   sudo tmutil removeexclusion -p "$p"
done
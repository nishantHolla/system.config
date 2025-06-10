#!/bin/sh

case "$1" in
  "get")
    IS_MUTE=`amixer  sget Master | grep "\[off\]"`

    if [[ "$IS_MUTE" == "" ]] ; then
      VOLUME=`amixer sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }' | sed 's/.$//'`
      echo -e "$VOLUME"
    else
      echo -e "0"
    fi

    exit;;

  "set")
    amixer sset Master "$2" --quiet
    exit;;

  "mute")
    amixer sset Master mute --quiet
    exit;;

  "unmute")
    amixer sset Master unmute --quiet
    exit;;

  "toggle")
    amixer sset Master toggle --quiet
    exit;;

  esac


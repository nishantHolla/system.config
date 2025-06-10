#!/bin/sh

if [[ "$1" == "previous" ]] ; then
	playerctl  previous
elif [[ "$1" == "next" ]] ; then
	playerctl next
elif [[ "$1" == "current" ]] ; then
	list=`playerctl -l | head -n 1`
	echo "$list"
elif [[ "$1" == "toggle" ]] ; then
	playerctl play-pause
elif [[ "$1" == "get-title" ]] ; then
	OUTPUT=`playerctl metadata title`
	echo "$OUTPUT"
elif [[ "$1" == "get-image" ]] ; then
	OUTPUT=`playerctl metadata | grep "artUrl" | awk '{print $3}'`
	echo "$OUTPUT"
elif [[ "$1" == "get-artist" ]] ; then
	OUTPUT=`playerctl metadata artist`
	echo "$OUTPUT"
fi

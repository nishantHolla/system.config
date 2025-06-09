#!/bin/sh

CURRENT_DIR=`pwd`
CONFIG_DIR="$CURRENT_DIR/rc.lua"
Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome -c "$CONFIG_DIR"

#!/bin/sh

OUTPUT=`df -h /`
echo "$OUTPUT" | awk 'NR==2 {print $5}' | sed 's/.$//'

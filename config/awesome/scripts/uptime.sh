#!/bin/sh

# Get the uptime part from uptime command
uptime_str=$(uptime | sed -E 's/^.* up\s+([0-9]+):([0-9]+),.*/\1 hr \2 min/')

echo $uptime_str

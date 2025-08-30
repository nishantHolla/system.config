#!/usr/bin/env python

from log import Log
import values as v

import sys

if __name__ == "__main__":
    args = sys.argv[:]
    program = args.pop(0)

    if len(args) == 0:
        Log.info("system", v.SYSTEM_USAGE, new_line=True)
        exit(1)

    command = args.pop(0)

    if command == "help":
        Log.info("system", v.SYSTEM_USAGE, new_line=True)

    else:
        Log.error(
            "system",
            f"Unknown command '{command}'\nRun 'system help' for list of commands",
        )
        exit(1)

    exit(0)

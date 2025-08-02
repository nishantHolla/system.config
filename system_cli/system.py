#!/usr/bin/env python
import sys
import values as v
from nixos import run as nixos_run
from home import run as home_run

if __name__ == "__main__":
    args = sys.argv
    program = args.pop(0)

    if len(args) == 0:
        print(v.SYSTEM_USAGE)
        exit(1)

    command = args.pop(0)

    if command == "help":
        print(v.SYSTEM_USAGE)

    elif command == "nixos":
        exit_code = nixos_run(args)
        if exit_code:
            exit(exit_code)

    elif command == "home":
        exit_code == home_run(args)
        if exit_code:
            exit(exit_code)

    else:
        print(f'Unknown command "{command}"\nRun "system help" for list of commands.')
        exit(1)

    exit(0)

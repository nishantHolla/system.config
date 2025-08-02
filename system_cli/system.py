#!/usr/bin/env python
import sys
import values as v

if __name__ == "__main__":
    args = sys.argv
    program = args.pop(0)

    if len(args) == 0:
        print(v.SYSTEM_USAGE)
        exit(1)

    command = args.pop(0)

    if command == "help":
        print(v.SYSTEM_USAGE)
    else:
        print(f'Unknown command "{command}"\nRun "system help" for list of commands')

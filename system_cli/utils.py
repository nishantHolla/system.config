from log import Log

import subprocess
import os


def run(author, command, capture=False, silent=False):
    if not silent:
        command_str = " ".join(command) if type(command) is list else command
        Log.info(author, f"Running {command_str}")

    if capture:
        result = subprocess.run(
            command, capture_output=True, text=True, check=True, shell=True
        )

        return result.stdout, result.returncode, result.stderr

    else:
        return os.system(command)


def find_and_replace(file_path, find, replace):
    try:
        with open(file_path, "r") as file:
            data = file.read()

        data = data.replace(find, replace)

        with open(file_path, "w") as file:
            file.write(data)

        return 0, None

    except Exception as e:
        return 1, e

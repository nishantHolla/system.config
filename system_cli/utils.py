import subprocess
import os


def run(command):
    result = subprocess.run(
        command, capture_output=True, text=True, check=True, shell=True
    )

    return result.stdout, result.returncode, result.stderr


def run_sys(command):
    return os.system(command)


def find_and_replace(file_path, find, replace):
    with open(file_path, "r") as file:
        data = file.read()

    data = data.replace(find, replace)

    with open(file_path, "w") as file:
        file.write(data)

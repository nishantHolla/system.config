class Log:
    def __init__(self):
        raise RuntimeError("Log class can not be initialized")

    @staticmethod
    def info(author, message, new_line=False):
        print(f"{author} [info ]: {'\n' if new_line else ''}{message}")

    @staticmethod
    def error(author, message, new_line=False):
        print(f"{author} [error]: {'\n' if new_line else ''}{message}")

    @staticmethod
    def warn(author, message, new_line=False):
        print(f"{author} [warn ]: {'\n' if new_line else ''}{message}")

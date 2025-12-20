local values_m = {}

-- Directories

values_m.awesome_dir = os.getenv("HOME") .. "/.config/awesome"
values_m.data_dir = os.getenv("HOME") .. "/.local/share/awesome"

-- Notify

values_m.notify = {
  history_file = values_m.data_dir .. '/notification_history.txt',

  silence = false,
  quiet = true,

  blacklist = {
    { title = "Firefox", app_name = "KDE Connect" },
  },
}


return values_m

local values_m = {}

-- Directories

values_m.awesome_dir = os.getenv("HOME") .. '/.config/awesome'
values_m.data_dir = os.getenv("HOME") .. '/.local/share/awesome'

-- Files

values_m.notification_history_file = values_m.data_dir .. '/notification_history.txt'

return values_m

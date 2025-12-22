local values_m = {}

-- Directories

values_m.awesome_dir = os.getenv("HOME") .. "/.config/awesome"
values_m.data_dir = os.getenv("HOME") .. "/.local/share/awesome"

-- Files

values_m.notification_history_file = values_m.data_dir .. "/notification_history.txt"

-- Applications

values_m.terminal = "alacritty"
values_m.editor = "nvim"
values_m.browser = "firefox"
values_m.file_manager = "pcmanfm"
values_m.editor_cmd = values_m.terminal .. " -e " .. values_m.editor

-- Layouts and Tags

values_m.layout_suit = AwesomeWM.awful.layout.suit
values_m.tag_layouts = {
  values_m.layout_suit.max.fullscreen,
  values_m.layout_suit.tile.right,
  values_m.layout_suit.tile.top,
  values_m.layout_suit.spiral,
  values_m.layout_suit.floating
}

values_m.tags = AwesomeWM.sharedtags({
  { name = "1", layout = values_m.tag_layouts[1], key = "a" },
  { name = "2", layout = values_m.tag_layouts[1], key = "s" },
  { name = "3", layout = values_m.tag_layouts[1], key = "d" },
  { name = "4", layout = values_m.tag_layouts[1], key = "f" },
  { name = "5", layout = values_m.tag_layouts[1], key = "g" },
})

-- Functions

values_m.init_values = function()
  terminal = values_m.terminal
  editor = values_m.editor
  editor_cmd = values_m.editor_cmd

  AwesomeWM.awful.layout.layouts = values_m.tag_layouts

  local g = AwesomeWM.awful.screen.focused().geometry
  values_m.screen_width = g.width
  values_m.screen_height = g.height
end


return values_m

local keymaps_m = {}

local mod = "Mod4"
keymaps_m.modkey = mod
keymaps_m.list = {
  ["test"] = {
    {
      {mod}, "t",
      function()
        AwesomeWM.awful.spawn("alacritty")
      end,
      "testing"
    }
  }
}

keymaps_m.make_keymap = function(map, group_name)
  return AwesomeWM.awful.key(
    map[1], -- Modifiers
    map[2], -- Key
    map[3], -- Callback
    { description = map[4], group = group_name }
  )
end

keymaps_m.init_keymaps = function()
  modkey = keymaps_m.modkey

  local keymaps = {}
  for group_name, group_list in pairs(keymaps_m.list) do
    for _, map in pairs(group_list) do
      keymaps = AwesomeWM.gears.table.join(
        keymaps,
        keymaps_m.make_keymap(map, group_name)
      )
    end
  end
  AwesomeWM.root.keys(keymaps)
end

return keymaps_m

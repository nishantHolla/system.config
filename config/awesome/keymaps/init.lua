local keymaps_m = {}
local mod = "Mod4"

keymaps_m.modkey = mod
keymaps_m.list = {

  ["Awesome"] = {
    {
      { mod }, "`",
      function()
        AwesomeWM.widgets.dashboard.toggle()
      end,
      "Toggle dashboard"
    },
    {
      { mod }, "1",
      function()
        AwesomeWM.functions.restart()
      end,
      "Restart awesome"
    },
    {
      { mod }, "2",
      function()
        AwesomeWM.functions.spawn("rofi -show window")
      end,
      "Show open clients"
    },
    {
      { mod }, "3",
      function()
        AwesomeWM.functions.power.lock(true)
      end,
      "Turn off screen"
    },
    {
      { mod }, "4",
      function()
        AwesomeWM.widgets.overlays.toggle()
      end,
      "Toggle overlays"
    },
    {
      { mod, "Shift" }, "3",
      function()
        AwesomeWM.functions.power.lock(false)
      end,
      "Lock the computer"
    },
    {
      { mod }, "Escape",
      function()
        AwesomeWM.functions.spawn_with_shell("power-menu")
      end,
      "Show power menu"
    }
  },

  ["Brightness Controls"] = {
    {
      {}, "XF86MonBrightnessUp",
      function()
        AwesomeWM.functions.brightness.increase()
      end,
      "Increase brightness"
    },
    {
      {}, "XF86MonBrightnessDown",
      function()
        AwesomeWM.functions.brightness.decrease()
      end,
      "Decrease brightness"
    }
  },

  ["Volumn Controls"] = {
    {
      {}, "XF86AudioRaiseVolume",
      function()
        AwesomeWM.functions.volume.increase()
      end,
      "Increase vloume"
    },
    {
      {}, "XF86AudioLowerVolume",
      function()
        AwesomeWM.functions.volume.decrease()
      end,
      "Decrase volume"
    },
    {
      {}, "XF86AudioMute",
      function()
        AwesomeWM.functions.volume.toggle()
      end,
      "Toggle volume"
    }
  },

  ["Player Controls"] = {
    {
      {}, "XF86AudioPrev",
      function()
        AwesomeWM.functions.player.previous()
      end,
      "Play previous"
    },
    {
      {}, "XF86AudioNext",
      function()
        AwesomeWM.functions.player.next()
      end,
      "Play next"
    },
    {
      {}, "XF86AudioPlay",
      function()
        AwesomeWM.functions.player.toggle()
      end,
      "Toggle player"
    }
  },

  ["Applications"] = {
    {
      { mod }, "Return",
      function()
        AwesomeWM.functions.spawn_with_shell("terminal")
      end,
      "Spawn " .. AwesomeWM.values.terminal
    },
    {
      { mod }, "'",
      function()
        AwesomeWM.functions.spawn(AwesomeWM.values.browser)
      end,
      "Spawn " .. AwesomeWM.values.browser
    },
    {
      { mod }, ";",
      function()
        AwesomeWM.functions.spawn(AwesomeWM.values.file_manager)
      end,
      "Spawn " .. AwesomeWM.values.file_manager
    },
    {
      { mod }, "space",
      function()
        AwesomeWM.functions.spawn_with_shell("open")
      end,
      "Launcher"
    },
    {
      { mod }, "Print",
      function()
        AwesomeWM.functions.spawn("flameshot gui")
      end,
      "Take screenshot"
    }
  },

  ["Client Movement"] = {
    {
      { mod }, "h",
      function()
        AwesomeWM.awful.client.focus.bydirection("left")
      end,
      "Move focus to left client"
    },
    {
      { mod }, "j",
      function()
        AwesomeWM.awful.client.focus.bydirection("down")
      end,
      "Move focus to bottom client"
    },
    {
      { mod }, "k",
      function()
        AwesomeWM.awful.client.focus.bydirection("up")
      end,
      "Move focus to top client"
    },
    {
      { mod }, "l",
      function()
        AwesomeWM.awful.client.focus.bydirection("right")
      end,
      "Move focus to right client"
    },
    {
      { mod }, "i",
      function()
        AwesomeWM.awful.client.focus.byidx(-1)
      end,
      "Move focus to previous client"
    },
    {
      { mod }, "o",
      function()
        AwesomeWM.awful.client.focus.byidx(1)
      end,
      "Move focus to next client"
    }
  },

  ["Client Management"] = {
    {
      { mod, "Shift" }, "h",
      function()
        AwesomeWM.awful.client.swap.bydirection("left")
      end,
      "Swap client with left"
    },
    {
      { mod, "Shift" }, "j",
      function()
        AwesomeWM.awful.client.swap.bydirection("down")
      end,
      "Swap client with bottom"
    },
    {
      { mod, "Shift" }, "k",
      function()
        AwesomeWM.awful.client.swap.bydirection("up")
      end,
      "Swap client with top"
    },
    {
      { mod, "Shift" }, "l",
      function()
        AwesomeWM.awful.client.swap.bydirection("right")
      end,
      "Swap client with right"
    },
    {
      { mod }, "c",
      function()
        AwesomeWM.functions.clients.close()
      end,
      "Close client"
    },
    {
      { mod, "Shift" }, "c",
      function()
        AwesomeWM.functions.clients.toggle_client_property("not_to_kill")
      end,
      "Toggle not_to_kill property"
    },
    {
      { mod }, "v",
      function()
        AwesomeWM.functions.clients.toggle_client_property("floating")
      end,
      "Toggle floating property"
    },
    {
      { mod, "Shift" }, "v",
      function()
        AwesomeWM.functions.clients.toggle_client_property("ontop")
      end,
      "Toggle ontop property"
    },
    {
      { mod }, "b",
      function()
        AwesomeWM.functions.clients.toggle_client_property("sticky")
      end,
      "Toggle sticky property"
    },
    {
      { mod }, "n",
      function()
        AwesomeWM.functions.clients.toggle_client_property("fullscreen")
      end,
      "Toggle fullscreen property"
    },
    {
      { mod }, "minus",
      function()
        AwesomeWM.awful.tag.incmwfact(-0.05)
      end,
      "Decrease master client size"
    },
    {
      { mod }, "equal",
      function()
        AwesomeWM.awful.tag.incmwfact(0.05)
      end,
      "Increase master client size"
    },
    {
      { mod, "Shift" }, "minus",
      function()
        AwesomeWM.awful.tag.incmaster(-1, nil, true)
      end,
      "Decrease master client count"
    },
    {
      { mod, "Shift" }, "equal",
      function()
        AwesomeWM.awful.tag.incmaster(1, nil, true)
      end,
      "Increase master client count"
    }
  },

  ["Floating Clients"] = {
    {
      { mod }, "Right",
      function()
				AwesomeWM.client.focus:relative_move(AwesomeWM.values.client_geometry_step, 0, 0, 0)
      end,
      "Move client right"
    },
    {
      { mod }, "Down",
      function()
				AwesomeWM.client.focus:relative_move(0, AwesomeWM.values.client_geometry_step, 0, 0)
      end,
      "Move client down"
    },
    {
      { mod }, "Left",
      function()
				AwesomeWM.client.focus:relative_move(-1 * AwesomeWM.values.client_geometry_step, 0, 0, 0)
      end,
      "Move client left"
    },
    {
      { mod }, "Up",
      function()
				AwesomeWM.client.focus:relative_move(0, -1 * AwesomeWM.values.client_geometry_step, 0, 0)
      end,
      "Move client up"
    },
    {
      { mod, "Ctrl" }, "Right",
      function()
				AwesomeWM.client.focus:relative_move(0, 0, AwesomeWM.values.client_geometry_step, 0)
      end,
      "Increase width of the client"
    },
    {
      { mod, "Ctrl" }, "Left",
      function()
				AwesomeWM.client.focus:relative_move(0, 0, -1 * AwesomeWM.values.client_geometry_step, 0)
      end,
      "Decrease width of the client"
    },
    {
      { mod, "Ctrl" }, "Down",
      function()
				AwesomeWM.client.focus:relative_move(0, 0, 0, -1 * AwesomeWM.values.client_geometry_step)
      end,
      "Decrease height of the client"
    },
    {
      { mod, "Ctrl" }, "Up",
      function()
				AwesomeWM.client.focus:relative_move(0, 0, 0, AwesomeWM.values.client_geometry_step)
      end,
      "Increase height of the client"
    }
  },

  ["Tag Movement"] = { },

  ["Tag Management"] = {
    {
      { mod }, "Tab",
      function()
        AwesomeWM.functions.tags.cycle_layout(1)
      end,
      "Cycle tag layout to next"
    },
    {
      { mod, "Shift" }, "Tab",
      function()
        AwesomeWM.functions.tags.cycle_layout(-1)
      end,
      "Cycle tag layout to previous"
    }
  }
}

keymaps_m.add_tag_keymaps = function()
  for _, t in pairs(AwesomeWM.values.tags) do
    table.insert(keymaps_m.list["Tag Movement"], {
      { mod }, t.key,
      function()
        AwesomeWM.functions.tags.move_to_tag(t.name)
      end,
      "Move to tag " .. t.name
    })

    table.insert(keymaps_m.list["Tag Movement"], {
      { mod, "Shift" }, t.key,
      function()
        AwesomeWM.functions.tags.move_client_to_tag(t.name)
      end,
      "Move current client to tag " .. t.name
    })
  end
end

keymaps_m.get_client_buttons = function()
  local client_buttons = AwesomeWM.gears.table.join(
    AwesomeWM.awful.button({}, 1, function(client)
      client:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    AwesomeWM.awful.button({ keymaps_m.modkey }, 1, function(client)
      client:emit_signal("request::activate", "mouse_click", { raise = true })
      AwesomeWM.awful.mouse.client.move(_client)
    end),
    AwesomeWM.awful.button({ keymaps_m.modkey }, 3, function(client)
      client:emit_signal("request::activate", "mouse_click", { raise = true })
      AwesomeWM.awful.mouse.client.resize(_client)
    end),
    AwesomeWM.awful.button({ keymaps_m.modkey }, 2, function(client)
      if client then client:kill() end
    end)
  )

  return client_buttons
end

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
  keymaps_m.add_tag_keymaps()

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

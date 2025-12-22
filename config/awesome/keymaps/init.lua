local keymaps_m = {}

local mod = "Mod4"
keymaps_m.modkey = mod
keymaps_m.list = {

  ["Awesome"] = {
    {
      { mod }, "`",
      function()
        -- TODO: Toggle dashboard
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
      { mod, "Shitf" }, "3",
      function()
        AwesomeWM.functions.power.lock(false)
      end,
      "Lock the computer"
    },
    {
      { mod }, "4",
      function()
        -- TODO: Toggle overlays
      end,
      "Toggle overlays"
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

  ["Volume Controls"] = {
    {
      {}, "XF86AudioRaiseVolume",
      function()
        AwesomeWM.functions.volume.increase()
      end,
      "Increase volume"
    },
    {
      {}, "XF86AudioLowerVolume",
      function()
        AwesomeWM.functions.volume.decrease()
      end,
      "Decrease volume"
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
        AwesomeWM.awful.focus.byidx(-1)
      end,
      "Move focus to previous client"
    },
    {
      { mod }, "o",
      function()
        AwesomeWM.awful.focus.byidx(1)
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
      { mod }, "minus",
      function()
        AwesomeWM.awful.tag.incmwfact(-0.05)
      end,
      "Decrease master client size"
    },
    {
      {
        { mod }, "equal",
        function()
          AwesomeWM.awful.tag.incmwfact(0.05)
        end,
        "Increase master client size"
      }
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

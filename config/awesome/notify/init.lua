local notify_m = {}

notify_m.silence = false
notify_m.quiet = true

notify_m.blacklist = {
  { title = "Firefox", app_name = "KDE Connect" }
}

notify_m.normal = function(title, text)
  AwesomeWM.naughty.notify({
    preset = AwesomeWM.naughty.config.presets.normal,
    title = title,
    text = text
  })
end

notify_m.low = function(title, text)
  AwesomeWM.naughty.notify({
    preset = AwesomeWM.naughty.config.presets.low,
    title = title,
    text = text
  })
end

notify_m.critical = function(title, text)
  AwesomeWM.naughty.notify({
    preset = AwesomeWM.naughty.config.presets.critical,
    title = title,
    text = text
  })
end

notify_m.is_blacklisted = function(notification)
  for _, item in ipairs(notify_m.blacklist) do
    if item.title == notification.title and item.app_name == notification.app_name then
      return true
    end
  end

  return false
end

notify_m.init_notifications = function()
  AwesomeWM.naughty.config.notify_callback = function(notification)
    if notify_m.is_blacklisted(notification) then
      return nil
    end

    local file = io.open(AwesomeWM.values.notification_history_file, "a")
    local section = "---\n"

    if file then
      file:write(
        string.format(
          "Title: %s\nMessage: %s\nApp name: %s\nTime: %s\n%s",
          notification.title,
          notification.text,
          notification.app_name,
					os.date("%Y-%m-%d %H:%M:%S"),
					section
        )
      )
      file:close()
    end

    if notify_m.silence then
      AwesomeWM.naughty.destroy_all_notifications()
      return nil
    elseif not notify_m.quiet then
      AwesomeWM.functions.player.play_glitter()
    end

    return notification
  end
end

return notify_m

local notify_m = {}

notify_m.silence = false -- Do not display the notification
notify_m.quiet = true    -- Do not play notification sound

-- Ignore notifications that have the given title and app name
notify_m.blacklist = {

  { title = "Firefox", app_name = "KDE Connect" }

}

-- Notify using the normal preset
notify_m.normal = function(title, text)
  AwesomeWM.naughty.notify({
    preset = AwesomeWM.naughty.config.presets.normal,
    title = title,
    text = text
  })
end

-- Notify using the low preset
notify_m.low = function(title, text)
  AwesomeWM.naughty.notify({
    preset = AwesomeWM.naughty.config.presets.low,
    title = title,
    text = text
  })
end

-- Notify using the critical preset
notify_m.critical = function(title, text)
  AwesomeWM.naughty.notify({
    preset = AwesomeWM.naughty.config.presets.critical,
    title = title,
    text = text
  })
end

-- Check if the given notification is to be ignored according to the blacklist
notify_m.to_ignore = function(notification)
  for _, item in ipairs(notify_m.blacklist) do
    if item.title == notification.title and item.app_name == notification.app_name then
      return true
    end
  end

  return false
end

-- Initialize notification service
notify_m.init_notifications = function()
  AwesomeWM.naughty.config.notify_callback = function(notification)

    -- Check if notification needs to be ignored
    if notify_m.to_ignore(notification) then
      return nil
    end

    -- Write to notification file
    local notification_file = io.open(AwesomeWM.values.notification_history_file, "a")
    local section = "---\n"

    if notification_file then
      notification_file:write(
        string.format(
          "Title: %s\nMessage: %s\nApp name: %s\nTime: %s\n%s",
          notification.title,
          notification.text,
          notification.app_name,
          os.date("%Y-%m-%d %H:%M:%S"),
          section
        )
      )

      notification_file:close()
    end

    -- Check current notification settings
    if notify_m.silence then
      AwesomeWM.naughty.destroy_all_notifications()
      return nil
    elseif not notify_m.quiet then
      -- TODO: Play notification sound
    end

    return notification
  end
end

return notify_m

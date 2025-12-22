local assets_m = {}

assets_m.asset_dir = AwesomeWM.values.awesome_dir .. "/assets"
assets_m.wallpaper_dir = assets_m.asset_dir .. "/wallpapers"

if AwesomeWM.theme.is_dark_theme then
  assets_m.icon_color = "White"
else
  assets_m.icon_color = "Black"
end

assets_m.get_icon = function(icon_name)
  local location_1 = os.getenv("HOME") .. "/.local/share/icons/GI/GI_" .. icon_name .. assets_m.icon_color .. ".svg"

  if AwesomeWM.functions.is_file(location_1) then
    return location_1
  end

  return ""
end

assets_m.get_wallpaper = function(tag_name)
  local screen = AwesomeWM.awful.screen.focused()
  local wallpaper_path = nil

  if tag_name then
    local tag = AwesomeWM.awful.tag.find_by_name(screen, tag_name)
    if tag then
      wallpaper_path = (assets_m.wallpaper_dir .. "/" .. tag_name)
    end
  elseif screen.selected_tag then
    wallpaper_path = (assets_m.wallpaper_dir .. "/" .. screen.selected_tag.name)
  end


  if wallpaper_path ~= nil and AwesomeWM.functions.is_file(wallpaper_path) then
    return wallpaper_path
  else
    return (assets_m.wallpaper_dir .. "/default")
  end
end

assets_m.get_volume_icon = function(volume, max_volume)
  local icon = nil
  max_volume = max_volume or 100
  -- TODO: Find correct max_volume

  if volume > (3 * max_volume) / 4 then
    icon = assets_m.get_icon("volumeHigh")
  elseif volume > max_volume / 4 then
    icon = assets_m.get_icon("volumeMedium")
  elseif volume > 0 then
    icon = assets_m.get_icon("volumeLow")
  else
    icon = assets_m.get_icon("volumeMute")
  end

  return icon
end

assets_m.get_brightness_icon = function(brightness, max_brightness)
  local icon = nil
  max_brightness = max_brightness or 255
  -- TODO: Find correct max_brightness

  if brightness > (3 * max_brightness) / 4 then
    icon = assets_m.get_icon("brightnessHigh")
  elseif brightness > max_brightness / 4 then
    icon = assets_m.get_icon("brightnessMedium")
  else
    icon = assets_m.get_icon("brightnessLow")
  end

  return icon
end

return assets_m

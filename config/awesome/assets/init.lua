local assets_m = {}

assets_m.asset_dir = AwesomeWM.values.awesome_dir .. "/assets"
assets_m.layouts_dir = assets_m.asset_dir .. "/layouts"
assets_m.sound_dir = assets_m.asset_dir .. "/sounds"
assets_m.wallpaper_dir = assets_m.asset_dir .. "/wallpapers"

if AwesomeWM.theme.is_dark_theme then
  assets_m.icon_color = "White"
else
  assets_m.icon_color = "Black"
end

assets_m.get_image = function(image_name)
  return assets_m.asset_dir .. "/" .. image_name .. ".png"
end

assets_m.get_sound = function(sound_name)
  return assets_m.sound_dir .. "/" .. sound_name .. ".mp3"
end

assets_m.get_layout_icon = function(layout_name)
	layout_name = layout_name or tostring(AwesomeWM.awful.screen.focused().selected_tag.layout.name)

	if
		layout_name ~= "spiral"
		and layout_name ~= "fullscreen"
		and layout_name ~= "floating"
		and layout_name ~= "tile"
		and layout_name ~= "tiletop"
	then
		AwesomeWM.notify.critical("Could not find layout icon of layout" .. layout_name)
		return ""
	end
	return assets_m.layouts_dir .. "/" .. layout_name .. ".jpg"
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

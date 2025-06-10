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

assets_m.get_icon = function(icon_name)
  local location_1 = os.getenv("HOME") .. "/.local/share/icons/GI/GI_" .. icon_name .. assets_m.icon_color .. ".svg"

  if AwesomeWM.functions.is_file(location_1) then
    return location_1
  end

  return ""
end

assets_m.get_asset = function(asset_path)
  return (assets_m.asset_dir .. "/" .. asset_path)
end

assets_m.get_sound = function(sound_name)
  return (assets_m.sound_dir .. "/" .. sound_name)
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
	return (assets_m.layouts_dir .. "/" .. layout_name .. ".jpg")
end

assets_m.get_volume_icon = function(volume)
  local icon = nil

  if volume > 75 then
    icon = AwesomeWM.assets.get_icon("volumeHigh")
  elseif volume > 25 then
    icon = AwesomeWM.assets.get_icon("volumeMedium")
  elseif volume > 0 then
    icon = AwesomeWM.assets.get_icon("volumeLow")
  else
    icon = AwesomeWM.assets.get_icon("volumeMute")
  end

  return icon
end

assets_m.get_brightness_icon = function(brightness)
  local icon = nil

  if brightness > 180 then
    icon = AwesomeWM.assets.get_icon("brightnessHigh")
  elseif brightness > 80 then
    icon = AwesomeWM.assets.get_icon("brightnessMedium")
  else
    icon = AwesomeWM.assets.get_icon("brightnessLow")
  end

  return icon
end

assets_m.get_wallpaper = function(tag_name)
  local focused_screen = AwesomeWM.awful.screen.focused()
  local wallpaper_path = nil

  if tag_name then
    local tag = AwesomeWM.awful.tag.find_by_name(focused_screen, tag_name)
    if tag then
      wallpaper_path = (assets_m..walpaper_dir .. "/" .. tag_name)
    end
  elseif focused_screen.selected_tag then
    wallpaper_path = (assets_m.wallpaper_dir .. "/" .. focused_screen.selected_tag.name)
  end

  if AwesomeWM.functions.is_file(wallpaper_path) then
    return wallpaper_path
  else
    return (assets_m.wallpaper_dir .. "/default")
  end

end

return assets_m

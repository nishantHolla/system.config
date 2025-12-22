local assets_m = {}

assets_m.asset_dir = AwesomeWM.values.awesome_dir .. "/assets"
assets_m.wallpaper_dir = assets_m.asset_dir .. "/wallpapers"

if AwesomeWM.theme.is_dark_theme then
  assets_m.icon_color = "White"
else
  assets_m.icon_color = "Black"
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

return assets_m

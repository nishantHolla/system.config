local media_player = {}
local utils = require("widgets.dashboard.utils")

media_player.prev_button = utils.make_icon_button('skipPrevious', function()
  AwesomeWM.functions.player.previous()
end)

media_player.play_pause_button = utils.make_icon_button('playPause', function()
  AwesomeWM.functions.player.toggle()
end)

media_player.next_button = utils.make_icon_button('skipNext', function()
  AwesomeWM.functions.player.next()
end)

media_player.controls = AwesomeWM.wibox.widget({
  media_player.prev_button.main,
  media_player.play_pause_button.main,
  media_player.next_button.main,
  spacing = 20,
  layout = AwesomeWM.wibox.layout.fixed.horizontal
})

media_player.info = AwesomeWM.wibox.widget({
  text = "Nothing is playing right now",
  font = AwesomeWM.theme.default_font .. ' 16',
  align = "center",
  valign = "center",
  forced_height = 150,
  widget = AwesomeWM.wibox.widget.textbox
})

media_player.main = AwesomeWM.wibox.widget({
  media_player.info,
  {
    media_player.controls,
    halign = 'center',
    widget = AwesomeWM.wibox.container.place
  },
  layout = AwesomeWM.wibox.layout.align.vertical
})

media_player.refresh = function()
  AwesomeWM.functions.player.find_metadata_and("title", function(title)
    if title == "" then
      title = "Nothing is playing right now"
    end

    media_player.info.text = title
  end)
end


return media_player

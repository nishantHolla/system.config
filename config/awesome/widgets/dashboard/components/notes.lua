local notes_component = {}
local utils = require("widgets.dashboard.utils")

notes_component.get_notes = function()
  local notes = {}
  local notes_file = AwesomeWM.values.notes_file

  if AwesomeWM.gears.filesystem.file_readable(notes_file) == false then
    AwesomeWM.notify.critical("Notes file is not readable")
    return {}
  end

  local is_title = true
  local title = ""
  local counter = 1

  for line in io.lines(notes_file) do
    if line == "" then
      is_title = true
      goto continue
    end

    if is_title then
      notes[counter] = {title = line, body = ""}
      title = line
      is_title = false
      counter = counter + 1
    else
      if notes[counter - 1].body == "" then
        notes[counter - 1].body = line
      else
        notes[counter - 1].body = notes[counter - 1].body .. "\n" .. line
      end
    end
    ::continue::
  end

  return notes
end

notes_component.notes = AwesomeWM.wibox.widget({
  spacing = 10,
  layout = AwesomeWM.wibox.layout.fixed.vertical
})

notes_component.main = AwesomeWM.wibox.widget({
  notes_component.notes,
  margins = 10,
  widget = AwesomeWM.wibox.container.margin
})

notes_component.make_note = function(n)
  local note = {}

	note.title = AwesomeWM.wibox.widget({
		markup = "<b>" .. n.title .. "</b>",
		font = AwesomeWM.theme.default_font .. " 20",
		widget = AwesomeWM.wibox.widget.textbox,
	})

	note.title_box = AwesomeWM.wibox.widget({
		{
			note.title,
			margins = 5,
			widget = AwesomeWM.wibox.container.margin,
		},
		fg = AwesomeWM.theme.black,
    bg = AwesomeWM.theme.white,
		shape = AwesomeWM.gears.shape.rounded_rect,
		widget = AwesomeWM.wibox.container.background,
	})

	note.body = AwesomeWM.wibox.widget({
		text = n.body,
		font = AwesomeWM.theme.default_font .. " 15",
		widget = AwesomeWM.wibox.widget.textbox,
	})

	note.body_box = AwesomeWM.wibox.widget({
		{
			note.body,
			margins = 5,
			widget = AwesomeWM.wibox.container.margin,
		},
		fg = AwesomeWM.theme.white,
		bg = AwesomeWM.theme.gray,
		shape = AwesomeWM.gears.shape.rounded_rect,
		widget = AwesomeWM.wibox.container.background,
	})

	note.layout = AwesomeWM.wibox.widget({
		note.title_box,
		note.body_box,
		spacing = 5,
		widget = AwesomeWM.wibox.layout.fixed.vertical,
	})

	note.content = AwesomeWM.wibox.widget({
		note.layout,
		margins = 10,
		widget = AwesomeWM.wibox.container.margin,
	})

	note.main = AwesomeWM.wibox.widget({
		note.content,
		bg = AwesomeWM.theme.gray,
		fg = AwesomeWM.theme.white,
		shape = AwesomeWM.gears.shape.rounded_rect,
		widget = AwesomeWM.wibox.container.background,
	})

  return note
end

notes_component.edit_button = AwesomeWM.wibox.widget({
  utils.margin_box({
    markup = "<b>Edit</b>",
    align = "center",
    valign = "center",
    font = AwesomeWM.theme.default_font .. " 16",
    widget = AwesomeWM.wibox.widget.textbox
  }, 10),
  bg = AwesomeWM.theme.white,
  fg = AwesomeWM.theme.black,
  shape = AwesomeWM.gears.shape.rounded_rect,
  widget = AwesomeWM.wibox.container.background
})


local enter_callback = function()
  notes_component.edit_button.bg = AwesomeWM.theme.dashboard_active_button_bg
  notes_component.edit_button.fg = AwesomeWM.theme.dashboard_active_button_fg
end

local exit_callback = function()
  notes_component.edit_button.bg = AwesomeWM.theme.white
  notes_component.edit_button.fg = AwesomeWM.theme.black
end

local open_notes = function()
  AwesomeWM.functions.spawn(AwesomeWM.values.editor_cmd .. " " .. AwesomeWM.values.notes_file)
  AwesomeWM.widgets.dashboard.hide()
end

utils.add_button_actions(notes_component.edit_button, open_notes, enter_callback, exit_callback)

notes_component.refresh = function()
  local notes = notes_component.get_notes()
  notes_component.notes:reset()

  notes_component.notes:add(notes_component.edit_button)

  for _, note in pairs(notes) do
    notes_component.notes:add(notes_component.make_note(note).main)
  end

end

notes_component.refresh()

return notes_component

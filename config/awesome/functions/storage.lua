local storage_sm = {}


storage_sm.get = function()
  return AwesomeWM.values.get_script("storage")
end

storage_sm.find_storage_and = function(callback)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async(storage_sm.get(), function(stdout, stderr, error_reason, exit_code)
    local storage = tonumber(stdout)
    local icon = AwesomeWM.assets.get_icon("hardDrive")
    callback(icon, storage)
  end)
end

return storage_sm

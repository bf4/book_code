{ControlPanel} = require './ControlPanel'
World = (callback) ->
  @controlPanel = new ControlPanel
  callback()
exports.World = World

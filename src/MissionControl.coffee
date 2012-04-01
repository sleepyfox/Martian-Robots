# Require needed for nextRobot to return a Robot object
Robot = (require '../src/Robot').Robot

class MissionControl
  constructor: (@input) ->
    if @input.length is 0
      throw new Error "No signal from Command"
    [long, lat] = @input.shift().split /\s+/
    @longitudeSize = parseInt long
    @latitudeSize = parseInt lat
    if (isNaN @longitudeSize) or (isNaN @latitudeSize)
      throw new Error "Grid specification invalid"
    if @longitudeSize > 50 or @longitudeSize < 0
      throw new Error "longitudeSize out of bounds #{@longitudeSize}"
    if @latitudeSize > 50 or @latitudeSize < 0
      throw new Error "latitudeSize out of bounds #{@latitudeSize}"

  nextRobot: ->
    unless @input?
      throw new Error "No robot specification found"
    if @input.length is 0
      null # EOF
    else
      line = @input.shift()
      while line.match(/^\d+/) is null
        line = @input.shift()
      [long, lat, dir] = line.split /\s+/
      x = parseInt long
      if x < 0 or x > @longitudeSize
        throw new Error "Robot X parameter #{x} out of bounds"
      y = parseInt lat
      if y < 0 or y > @latitudeSize
        throw new Error "Robot Y parameter #{y} out of bounds"
      if dir not in ['N', 'S', 'E', 'W']
        throw new Error "Robot facing parameter #{dir} out of bounds"
      robot = new Robot x, y, dir

  nextRobotInstructions: ->
    line = @input.shift()
    if (line.match(/^[LRF]+\s*$/) is null)
      throw new Error "Invalid robot instructions"
    if line.length > 100
      throw new Error "Robot instructions too long: #{line.length} > 100"
    line

exports.MissionControl = MissionControl

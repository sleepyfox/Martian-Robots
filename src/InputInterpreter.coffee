r = require '../src/Robot' # needed for nextRobot to return a Robot object
Robot = r.Robot

class InputInterpreter
  constructor: (@input) ->
    throw "Empty input array!" if @input.length is 0
    [long, lat] = @input.shift().split /\s+/
    @longitudeSize = parseInt long
    @latitudeSize = parseInt lat
    if (isNaN @longitudeSize) or (isNaN @latitudeSize) 
      throw "Grid specification invalid"
    if @longitudeSize > 50 or @longitudeSize < 0
      throw "longitudeSize out of bounds #{@longitudeSize}"
    if @latitudeSize > 50 or @latitudeSize < 0
      throw "latitudeSize out of bounds #{@latitudeSize}"

  nextRobot: ->
    throw "No input" unless @input?
    line = @input.shift()
    while line.match(/^\d+/) is null
      line = @input.shift()
    [long, lat, dir] = line.split /\s+/
    x = parseInt long
    if x < 0 or x > @longitudeSize
      throw "Robot X parameter #{x} out of bounds"
    y = parseInt lat
    if y < 0 or y > @latitudeSize
      throw "Robot Y parameter #{y} out of bounds"
    if dir not in ['N', 'S', 'E', 'W']
      throw "Robot facing parameter #{dir} out of bounds"
    robot = new Robot x, y, dir

  nextRobotInstructions: ->
    line = @input.shift()
    if (line.match(/^[LRF]+\s*$/) is null)
      throw "Invalid robot instructions"
    if line.length > 100
      throw "Robot instructions too long: #{line.length} > 100"
    line

exports.InputInterpreter = InputInterpreter

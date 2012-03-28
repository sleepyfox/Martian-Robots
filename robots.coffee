class Grid
  constructor: (@minx = 0, @miny = 0, @maxx = 0, @maxy = 0) ->
    @size = (@maxx - @minx + 1) * (@maxy - @miny + 1)
    @deadSquares = []

  ifLostHere: (x, y, direction) ->
    "#{x}:#{y}:#{direction}" in @deadSquares
  
  markLost: (x, y, direction) ->
    @deadSquares.push "#{x}:#{y}:#{direction}"

  ifHasRoomToMove: (x, y, direction) ->
    if x < @minx or x > @maxx or y < @miny or y > @miny
      false
    else
      switch direction
        when 'N'
          y is not @maxy
        when 'S'
          y is not @miny
        when 'E'
          x is not @maxx
        when 'W'
          x is not @minx
 
class Robot
  constructor: (@x = 0, @y = 0, @facing = 'N') ->
    @left = {'N':'W', 'W':'S', 'S':'E', 'E':'N'}
    @right = {'N':'E', 'E':'S', 'S':'W', 'W':'N'}
    @lost = false

  moveForward: (grid) ->
    # this function returns null if the robot moved safely
    # if the robot is lost, it returns the composite key
    # of the coordinates and direction
    if @lost
      null # lost robots can't move!
    else
      if grid.ifLostHere(@x, @y, @facing)
        null # don't move, as have scent here, and not lost
      else
        if grid.ifHasRoomToMove(@x, @y, @facing)
          switch @facing
            when 'N' then @y++
            when 'S' then @y--
            when 'E' then @x++
            when 'W' then @x--
        else
          @lost = true
          "#{@x}:#{@y}:#{@facing}" # return the new lost composite key

  turnLeft: ->
    @facing = @left[@facing] unless @lost

  turnRight: ->
    @facing = @right[@facing] unless @lost

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

exports.Grid = Grid
exports.Robot = Robot
exports.InputInterpreter = InputInterpreter

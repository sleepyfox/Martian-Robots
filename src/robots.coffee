class Grid
  constructor: (@minx = 0, @miny = 0, @maxx = 0, @maxy = 0) ->
    @size = (@maxx - @minx + 1) * (@maxy - @miny + 1)
    @deadSquares = []

  ifLostHere: (x, y, direction) ->
    "#{x}:#{y}:#{direction}" in @deadSquares
  
  markLost: (x, y, direction) ->
    @deadSquares.push "#{x}:#{y}:#{direction}"

  ifHasRoomToMove: (x, y, direction) ->
    if x < @minx or x > @maxx or y < @miny or y > @maxy
      false
    else
      switch direction
        when 'N'
          y isnt @maxy
        when 'S'
          y isnt @miny
        when 'E'
          x isnt @maxx
        when 'W'
          x isnt @minx
 
class Robot
  constructor: (@x = 0, @y = 0, @facing = 'N') ->
    @left = {'N':'W', 'W':'S', 'S':'E', 'E':'N'}
    @right = {'N':'E', 'E':'S', 'S':'W', 'W':'N'}
    @lost = false

  moveForward: (grid) ->
    # this function returns true if the robot moved safely
    # if the robot is lost, it returns false, if the robot 
    # failed to move it returns null
    if @lost
      null # lost robots can't move!
    else
      if grid.ifLostHere(@x, @y, @facing)
        null # don't move, as have scent here, and not lost
      else
        if grid.ifHasRoomToMove(@x, @y, @facing)
          switch @facing
            when 'N'
              @y++
              true
            when 'S'
              @y--
              true
            when 'E'
              @x++
              true
            when 'W'
              @x--
              true
            else
              null
        else
          @lost = true
          grid.markLost @x, @y, @facing
          false

  processInstructions: (list, grid) ->
    throw 'Empty robot instruction string' if list.length is 0
    throw 'Invalid robot instructions' if list.match(/^[FRL]+$/) is null
    while list.length > 0 and not @lost
      switch list.charAt 0
        when 'F' then @moveForward(grid)
        when 'R' then @turnRight()
        when 'L' then @turnLeft()
        else throw "Invalid robot instruction #{list.charAt(0)}" # should never get here
      list = list.slice 1

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

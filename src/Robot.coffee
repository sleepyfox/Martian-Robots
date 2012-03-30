class Robot
  # Class private variables
  left = {'N':'W', 'W':'S', 'S':'E', 'E':'N'}
  right = {'N':'E', 'E':'S', 'S':'W', 'W':'N'}

  constructor: (@x = 0, @y = 0, @facing = 'N') ->
    @_lost = false

  moveForward: (grid) ->
    # Returns true if the robot moved safely,
    # if the robot is lost it returns false, 
    # if the robot failed to move it returns null.
    if @_lost
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
              null # should never get here!
        else
          @_lost = true
          grid.markLost @x, @y, @facing
          false

  isLost: ->
    @_lost

  processInstructions: (list, grid) ->
    throw 'Empty robot instruction string' if list.length is 0
    throw 'Invalid robot instructions' if list.match(/^[FRL]+$/) is null
    while list.length > 0 and not @_lost
      switch list.charAt 0
        when 'F' then @moveForward(grid)
        when 'R' then @turnRight()
        when 'L' then @turnLeft()
        else throw "Invalid robot instruction #{list.charAt(0)}" # should never get here
      list = list.slice 1

  turnLeft: ->
    @facing = left[@facing] unless @_lost

  turnRight: ->
    @facing = right[@facing] unless @_lost

exports.Robot = Robot

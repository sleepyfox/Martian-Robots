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
 
exports.Grid = Grid

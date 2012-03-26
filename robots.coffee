class Grid
  constructor: (@minx = 0, @miny = 0, @maxx = 0, @maxy = 0) ->
    @size = (@maxx - @minx + 1) * (@maxy - @miny + 1)
    @deadSquares = []

class Robot
  constructor: (@x = 0, @y = 0, @facing = 'N') ->
  
  forward: ->
  	null

  turnLeft: ->
  	switch @facing
  	  when 'N' then @facing = 'W'
  	  when 'E' then @facing = 'N'
  	  when 'S' then @facing = 'E'
  	  when 'W' then @facing = 'S' 

  turnRight: ->
  	switch @facing
  	  when 'N' then @facing = 'E'
  	  when 'W' then @facing = 'N'
  	  when 'S' then @facing = 'W'
  	  when 'E' then @facing = 'S' 
 
exports.Grid = Grid
exports.Robot = Robot
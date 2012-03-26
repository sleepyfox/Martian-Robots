class Grid
  constructor: (@minx = 0, @miny = 0, @maxx = 0, @maxy = 0) ->
    @size = (@maxx - @minx + 1) * (@maxy - @miny + 1)
    @deadSquares = []

class Robot
  constructor: (@x = 0, @y = 0, @facing = 'N') ->
    @left = {'N':'W', 'W':'S', 'S':'E', 'E':'N'}
    @right = {'N':'E', 'E':'S', 'S':'W', 'W':'N'}

  forward: ->
    null

  turnLeft: ->
    @facing = @left[@facing]

  turnRight: ->
    @facing = @right[@facing]
 
exports.Grid = Grid
exports.Robot = Robot
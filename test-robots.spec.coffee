robots = require './robots'
Grid = robots.Grid
Robot = robots.Robot

describe 'Given a new 1x1 grid (default size)', ->

  surface = new Grid 
  
  it 'when we calculate the size then it should be equal to 1', ->
    expect(surface.size).toEqual 1
  it 'when we count the number of dead squares then it should have no dead squares', ->
    expect(surface.deadSquares.length).toEqual 0

describe 'Given a new robot, Robby, with no paramaters', ->

  robby = new Robot
  
  it 'when created then Robby should face North', ->
    expect(robby.facing).toEqual 'N'
  it 'when created then Robby should start at 0,0', ->
    expect(robby.x).toEqual 0
    expect(robby.y).toEqual 0
  it 'when Robby turns Left, he should face West', ->
    robby.turnLeft()
    expect(robby.facing).toEqual 'W'
  it 'when Robby turns Left again, he should face South', ->
    robby.turnLeft()
    expect(robby.facing).toEqual 'S'
  it 'when Robby turns Left again, he should face East', ->
    robby.turnLeft()
    expect(robby.facing).toEqual 'E'
  it 'when Robby turns Left again, he should face North', ->
    robby.turnLeft()
    expect(robby.facing).toEqual 'N'
  it 'when Robby turns Right, he should face East', ->
    robby.turnRight()
    expect(robby.facing).toEqual 'E'
  it 'when Robby turns Right again, he should face South', ->
    robby.turnRight()
    expect(robby.facing).toEqual 'S'
  it 'when Robby turns Right again, he should face West', ->
    robby.turnRight()
    expect(robby.facing).toEqual 'W'
  it 'when Robby turns Right again, he should face North', ->
    robby.turnRight()
    expect(robby.facing).toEqual 'N'
  it 'when Robby moves Forward, then he should be lost!', ->
    expect(robby.forward()).toBeNull() 
  it 'when Robby is lost, then he cannot turn left', ->
    robby.turnLeft()
    expect(robby.facing).toEqual 'N'
  it 'when Robby is lost, then he cannot turn right', ->
    robby.turnRight()
    expect(robby.facing).toEqual 'N'
  it 'when Robby is lost, then he cannot move forward', ->
    expect(robby.forward()).toBeNull() 

describe 'Given a 1x1 grid and a two new robots, C3PO and R2D2', ->
  surface = new Grid
  c3po = new Robot
  r2d2 = new Robot

  it 'when C3PO moves forward, he is lost!', ->
    expect(c3po.forward()).toBeNull()
  it 'and the grid has one dead space', ->
    expect(surface.deadSquares.length).toEqual 1
  it 'and the dead space is at (0,0)', ->
    expect(surface.deadSquares[0].x).toEqual 0
    expect(surface.deadSquares[0].y).toEqual 0
  it 'and the cliff facing is North', ->
    expect(surface.deadSquares[0].facing).toEqual 'N'
  it 'when R2D2 moves forward, he is not lost', ->
    expect(r2d2.forward()).not.toBeNull()
  it 'and his position is unchanged',  ->
    expect(r2d2.x).toEqual 0
    expect(r2d2.y).toEqual 0

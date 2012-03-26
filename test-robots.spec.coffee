robots = require './robots'
Grid = robots.Grid
Robot = robots.Robot

describe 'Given a new 1x1 grid (default size)', ->

  surface = new Grid 
  
  it 'when we calculate the size then it should be equal to 1', ->
    expect(surface.size).toEqual 1
  it 'when we count the number of dead squares then it should have no dead squares', ->
    expect(surface.deadSquares.length).toEqual 0

describe 'Given a new robot, Robbie, with no paramaters', ->

  robbie = new Robot
  
  it 'when created then Robbie should face North', ->
    expect(robbie.facing).toEqual 'N'
  it 'when created then Robbie should start at 0,0', ->
    expect(robbie.x).toEqual 0
    expect(robbie.y).toEqual 0
  it 'when Robbie moves Forward, then he should be lost!', ->
    expect(robbie.forward()).toBeNull() 
  it 'when Robbie turns Left, he should face West', ->
    robbie.turnLeft()
    expect(robbie.facing).toEqual 'W'
  it 'when Robbie turns Left again, he should face South', ->
    robbie.turnLeft()
    expect(robbie.facing).toEqual 'S'
  it 'when Robbie turns Left again, he should face East', ->
    robbie.turnLeft()
    expect(robbie.facing).toEqual 'E'
  it 'when Robbie turns Left again, he should face North', ->
    robbie.turnLeft()
    expect(robbie.facing).toEqual 'N'
  it 'when Robbie turns Right, he should face East', ->
    robbie.turnRight()
    expect(robbie.facing).toEqual 'E'
  it 'when Robbie turns Right again, he should face South', ->
    robbie.turnRight()
    expect(robbie.facing).toEqual 'S'
  it 'when Robbie turns Right again, he should face West', ->
    robbie.turnRight()
    expect(robbie.facing).toEqual 'W'
  it 'when Robbie turns Right again, he should face North', ->
    robbie.turnRight()
    expect(robbie.facing).toEqual 'N'

     

fs = require 'fs'
robots = require './robots'
Grid = robots.Grid
Robot = robots.Robot
InputInterpreter = robots.InputInterpreter

loadFileToArray = (filePath) ->
  fs.readFileSync(filePath).toString().split("\n")

  
describe 'Given a new 1x1 grid (default size)', ->

  surface = new Grid 
  
  it 'when we calculate the size then it should be equal to 1', ->
    expect(surface.size).toEqual 1
  it 'when we count the number of dead squares then it should have no dead squares', ->
    expect(surface.deadSquares.length).toEqual 0
  it 'when looking for room to move, then there should be no room North', ->
    expect(surface.ifHasRoomToMove(0, 0, 'N')).toBeFalsy()
  it 'when looking for room to move, then there should be no room South', ->
    expect(surface.ifHasRoomToMove(0, 0, 'S')).toBeFalsy()
  it 'when looking for room to move, then there should be no room East', ->
    expect(surface.ifHasRoomToMove(0, 0, 'E')).toBeFalsy()
  it 'when looking for room to move, then there should be no room West', ->
    expect(surface.ifHasRoomToMove(0, 0, 'W')).toBeFalsy()

describe 'Given a new robot, Robby, with no paramaters', ->

  robby = new Robot

  it 'when created then Robby should face North', ->
    expect(robby.facing).toEqual 'N'
  it 'when created then Robby should start at 0,0', ->
    expect(robby.x).toEqual 0
    expect(robby.y).toEqual 0
  it 'when created Robby should not be lost', ->
    expect(robby.lost).toBeFalsy()
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

describe 'Given a 1x1 grid and a two new robots, C3PO and R2D2', ->
  surface = new Grid
  c3po = new Robot
  r2d2 = new Robot
  key = c3po.moveForward(surface)
  surface.markLost(c3po.x, c3po.y, c3po.facing) if key?
  
  it 'when C3PO moves forward, he is lost!', ->
    expect(c3po.lost).toBeTruthy()
    expect(key).not.toBeNull()
  it 'and the grid has one dead space', ->
    expect(surface.deadSquares.length).toEqual 1
  it 'and the dead space is at (0,0) facing North', ->
    expect(surface.deadSquares[0]).toEqual "0:0:N"
  it 'when R2D2 moves forward, he is not lost', ->
    key2 = r2d2.moveForward(surface)
    expect(r2d2.lost).toBeFalsy()
    expect(key2).toBeNull()
  it 'and his position is unchanged',  ->
    expect(r2d2.x).toEqual 0
    expect(r2d2.y).toEqual 0

describe 'Given a non-existant test file', ->
  it 'when we try and load it, then we get an error', ->
    try 
      array = loadFileToArray("non-existent-file")
      expect(array).toBeNull()
    catch error
      console.error error
      expect(error).not.toBeNull()

describe 'Given a one-line test file', ->
  array = []
  inputInterpreter = {}

  beforeEach ->
    try 
      array = loadFileToArray("one-line-test-file.dat")
    catch error
      console.error error
      expect(error).toBeNull() # fail the test suite if error
    inputInterpreter = new InputInterpreter array.slice() # pass by value

  it 'when we try and load it, then we get an array', ->
    expect(array).not.toBeNull()
  it 'and the array has one line', ->
    expect(array.length).toEqual 1
  it 'and the line is \"51 -3\"', ->
    expect(array[0]).toEqual "51 -3"
  it 'when we ask for latitude, then the interpreter should return OUT_OF_BOUNDS', ->
    expect(inputInterpreter.latitudeSize).toEqual "OUT_OF_BOUNDS"
  it 'when we ask for longitude, then the interpreter should return OUT_OF_BOUNDS', ->
    expect(inputInterpreter.longitudeSize).toEqual "OUT_OF_BOUNDS"

describe 'Given a simple test file', ->
  array = [] 
  inputInterpreter = {}
  gort = {}
  instructions = ""

  beforeEach ->
    try 
      array = loadFileToArray("simple-test-file.dat")
    catch error
      console.error error
      expect(error).toBeNull() # fail the test suite if error
    inputInterpreter = new InputInterpreter array.slice() # pass by value
    gort = inputInterpreter.nextRobot()
    instructions = inputInterpreter.nextRobotInstructions()

  it 'when we load it, then we get an array of 3 lines', ->
    expect(array.length).toEqual 3
  it 'when we look at the grid specification, then we should see a 5x3 grid', ->
    expect(inputInterpreter.latitudeSize).toEqual 3
    expect(inputInterpreter.longitudeSize).toEqual 5
  it 'when we look at the first robot, Gort; then we should get a robot at (1,1)', ->
    expect(gort.x).toEqual 1
    expect(gort.y).toEqual 1
  it 'and Gort should be facing East', ->
    expect(gort.facing).toEqual 'E'
  it 'and his instructions should be RFRFRFRF', ->
    expect(instructions).toEqual 'RFRFRFRF'


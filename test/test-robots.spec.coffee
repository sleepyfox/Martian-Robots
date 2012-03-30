fs = require 'fs'
r = require '../src/Robot'
g = require '../src/Grid'
i = require '../src/InputInterpreter'
Robot = r.Robot
Grid = g.Grid
InputInterpreter = i.InputInterpreter

# Helper function
loadFileToArray = (filePath) ->
  fs.readFileSync(filePath).toString().split("\n")

describe 'Given a new robot, Robby, with no paramaters', ->

  robby = new Robot
  surface = new Grid 0, 0, 1, 1 

  it 'when created then Robby should face North', ->
    expect(robby.facing).toEqual 'N'
  it 'when created then Robby should start at 0,0', ->
    expect(robby.x).toEqual 0
    expect(robby.y).toEqual 0
  it 'when created Robby should not be lost', ->
    expect(robby.isLost()).toBeFalsy()
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
  it 'when given an empty instruction string then we get an error', ->
    try
      robby.processInstructions "", surface
      expect(1).toBeNull()
    catch error
      expect(error).toEqual "Empty robot instruction string"
  it "when given a list of instructions that don't consist solely of [FRL] then we get an error", -> 
    try
      robby.processInstructions "T1000", surface
      expect(1).toBeNull()
    catch error
      expect(error).toEqual "Invalid robot instructions"
  
describe 'Given a 1x1 grid and a two new robots, C3PO and R2D2', ->
  surface = new Grid
  c3po = new Robot
  r2d2 = new Robot
  key = c3po.moveForward(surface)
  
  it 'when C3PO moves forward, he is lost!', ->
    expect(c3po.isLost()).toBeTruthy()
    expect(key).toBeFalsy()
  it 'and the grid has one dead space', ->
    expect(surface.getDeadSquares().length).toEqual 1
  it 'and the dead space is at (0,0) facing North', ->
    expect(surface.getDeadSquares()[0]).toEqual "0:0:N"
  it 'when R2D2 moves forward, he is not lost', ->
    key2 = r2d2.moveForward(surface)
    expect(r2d2.isLost()).toBeFalsy()
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
      expect(error.message).toEqual 'ENOENT, no such file or directory \'non-existent-file\''

describe 'Given a one-line test file', ->
  array = []
  inputInterpreter = {}

  beforeEach ->
    try
      array = loadFileToArray("test/one-line-test-file.dat")
    catch error
      console.error error
      expect(error).toBeNull() # fail the test suite if error
    inputInterpreter = new InputInterpreter array.slice() # pass by value

  it 'when we try and load it, then we get an array', ->
    expect(array).not.toBeNull()
  it 'and the array has one line', ->
    expect(array.length).toEqual 1
  it 'and the line is \"1 3\"', ->
    expect(array[0]).toEqual "1 3"
  it 'when we ask for latitude, then the interpreter should return 3', ->
    expect(inputInterpreter.latitudeSize).toEqual 3
  it 'when we ask for longitude, then the interpreter should return 1', ->
    expect(inputInterpreter.longitudeSize).toEqual 1

describe 'Given a the problem test file', ->
  array = []
  inputInterpreter = {}
  gort = {}
  instructions = ""

  try
    array = loadFileToArray("test/problem-test-file.dat")
  catch error
    console.error error
    expect(error).toBeNull() # fail the test suite if error

  it 'when we load it, then we get an array of 9 lines', ->
    expect(array.length).toEqual 9
  it 'when we look at the grid specification, then we should see a 5x3 grid', ->
    expect(inputInterpreter.latitudeSize).toEqual 3
    expect(inputInterpreter.longitudeSize).toEqual 5

  inputInterpreter = new InputInterpreter array.slice() # pass by value
  surface = new Grid 0, 0, inputInterpreter.longitudeSize, inputInterpreter.latitudeSize
  gort = inputInterpreter.nextRobot()
  instructions = inputInterpreter.nextRobotInstructions()

  it 'when we look at the first robot, Gort; then we should get a robot at (1,1)', ->
    expect(gort.x).toEqual 1
    expect(gort.y).toEqual 1
  it 'and Gort should be facing East', ->
    expect(gort.facing).toEqual 'E'
  it 'and his instructions should be RFRFRFRF', ->
    expect(instructions).toEqual 'RFRFRFRF'
  it 'when we process the instructions, then Gort should end up at position (1,1)', ->
    gort.processInstructions(instructions, surface)
    expect(gort.x).toEqual 1
    expect(gort.y).toEqual 1
  it 'and his facing should be East', ->
    expect(gort.facing).toEqual 'E'
  it 'and he should not be lost', ->
    expect(gort.isLost()).toBeFalsy()

  marvin = inputInterpreter.nextRobot()
  instructions2 = inputInterpreter.nextRobotInstructions()

  it 'when we look at the second robot, Marvin; then we should get a robot at (3,2)', ->
    expect(marvin.x).toEqual 3
    expect(marvin.y).toEqual 2
  it 'and Marvin should be facing North', ->
    expect(marvin.facing).toEqual 'N'
  it 'and his instructions should be FRRFLLFFRRFLL', ->
    expect(instructions2).toEqual 'FRRFLLFFRRFLL'
  it 'when we process the instructions, then Marvin should end up at position (3,3)', ->
    marvin.processInstructions(instructions2, surface)
    expect(marvin.x).toEqual 3
    expect(marvin.y).toEqual 3
  it 'and his facing should be North', ->
    expect(marvin.facing).toEqual 'N'
  it 'and he should be lost', ->
    expect(marvin.isLost()).toBeTruthy()

  k9 = inputInterpreter.nextRobot()
  instructions3 = inputInterpreter.nextRobotInstructions()

  it 'when we look at the third robot, K9; then we should get a robot at (0,3)', ->
    expect(k9.x).toEqual 0
    expect(k9.y).toEqual 3
  it 'and K9 should be facing West', ->
    expect(k9.facing).toEqual 'W'
  it 'and his instructions should be LLFFFLFLFL', ->
    expect(instructions3).toEqual 'LLFFFLFLFL'
  it 'when we process the instructions, then K9 should end up at position (2,3)', ->
    k9.processInstructions(instructions3, surface)
    expect(k9.x).toEqual 2
    expect(k9.y).toEqual 3
  it 'and his facing should be South', ->
    expect(k9.facing).toEqual 'S'
  it 'and he should not be lost', ->
    expect(k9.isLost()).toBeFalsy()


fs = require 'fs'
MissionControl = (require '../src/MissionControl').MissionControl

# Helper function
loadFileToArray = (filePath) ->
  fs.readFileSync(filePath).toString().split("\n")

describe 'Given a non-existant test file', ->
  it 'when we try and load it, then we get an error', ->
    try
      array = loadFileToArray("non-existent-file")
      expect(array).toBeNull()
    catch error
      expect(error.message).toEqual 'ENOENT, no such file or directory \'non-existent-file\''

describe 'Given a MissionControl', ->
  it 'when fed an empty array, then we get an error', ->
    try
      kennedy = new MissionControl [] 
      expect(1).toBeNull() # fail fixture if no exception
    catch error
      expect(error.message).toEqual "No signal from Command"
  it 'when we interpret a line of rubbish then we get an error', ->
    try
      kennedy = new MissionControl ["qwerty is great!"]
      expect(1).toBeNull() # fail fixture if no exception
    catch error
      expect(error.message).toEqual "Grid specification invalid"
  it 'when we interpret an initial line that has a non-numeric x coordinate, then we get an error', ->
    try
      kennedy = new MissionControl ["one-two 3"]
      expect(1).toBeNull() # fail fixture if no exception
    catch error
      expect(error.message).toEqual "Grid specification invalid"
  it 'when we interpret an initial line that has a non-numeric y coordinate, then we get an error', ->
    try
      kennedy = new MissionControl ["1 two-three"]
      expect(1).toBeNull() # fail fixture if no exception
    catch error
      expect(error.message).toEqual "Grid specification invalid"
  it 'when we interpret an initial line that has a negative x coordinate, then we get an error', ->
    try
      kennedy = new MissionControl ["-1 2"]
      expect(1).toBeNull() # fail fixture if no exception
    catch error
      expect(error.message).toEqual "longitudeSize out of bounds -1"
  it 'when we interpret an initial line that has a negative y coordinate, then we get an error', ->
    try
      kennedy = new MissionControl ["1 -2"]
      expect(1).toBeNull() # fail fixture if no exception
    catch error
      expect(error.message).toEqual "latitudeSize out of bounds -2"
  it 'when we interpret an initial line that has a x coordinate > 50, then we get an error', ->
    try
      kennedy = new MissionControl ["101 2"]
      expect(1).toBeNull() # fail fixture if no exception
    catch error
      expect(error.message).toEqual "longitudeSize out of bounds 101"
  it 'when we interpret an initial line that has a y coordinate > 50, then we get an error', ->
    try
      kennedy = new MissionControl ["1 666"]
      expect(1).toBeNull() # fail fixture if no exception
    catch error
      expect(error.message).toEqual "latitudeSize out of bounds 666"

describe 'Given a one-line test file', ->
  array = []
  kennedy = {}

  beforeEach ->
    try
      array = loadFileToArray("test/one-line-test-file.dat")
    catch error
      console.error error
      expect(error).toBeNull() # fail the test suite if error
    kennedy = new MissionControl array.slice() # pass by value

  it 'when we try and load it, then we get an array', ->
    expect(array).not.toBeNull()
  it 'and the array has one line', ->
    expect(array.length).toEqual 1
  it 'and the line is \"1 3\"', ->
    expect(array[0]).toEqual "1 3"
  it 'when we ask for latitude, then the interpreter should return 3', ->
    expect(kennedy.grid.maxy).toEqual 3
  it 'when we ask for longitude, then the interpreter should return 1', ->
    expect(kennedy.grid.maxx).toEqual 1

describe 'Given an MissionControl and a single line input array', ->
  array = ["5 3"]
  ames = new MissionControl array

  it 'when we interpret this, then we get a 5x3 grid', ->
    expect(ames.grid.maxx).toEqual 5
    expect(ames.grid.maxy).toEqual 3
  it 'when we ask for robot position, then we get an error', ->
    expect(ames.nextRobot).toThrow "No robot specification found"

describe 'Given a the problem test file', ->
  array = []
  kennedy = gort = {}
  instructions = ""

  try
    array = loadFileToArray("test/problem-test-file.dat")
  catch error
    console.error error
    expect(error).toBeNull() # fail the test suite if error

  kennedy = new MissionControl array.slice() # pass by value
  cydonia = kennedy.grid
  gort = kennedy.nextRobot()
  instructions = kennedy.nextRobotInstructions()

  it 'when we load it, then we get an array of 9 lines', ->
    expect(array.length).toEqual 9
  it 'when we look at the grid specification, then we should see a 5x3 grid', ->
    expect(cydonia.maxy).toEqual 3
    expect(cydonia.maxx).toEqual 5
  it 'when we look at the first robot, Gort; then we should get a robot at (1,1)', ->
    expect(gort.x).toEqual 1
    expect(gort.y).toEqual 1
  it 'and Gort should be facing East', ->
    expect(gort.facing).toEqual 'E'
  it 'and his instructions should be RFRFRFRF', ->
    expect(instructions).toEqual 'RFRFRFRF'
  it 'when we process the instructions, then Gort should end up at position (1,1)', ->
    gort.processInstructions(instructions, cydonia)
    expect(gort.x).toEqual 1
    expect(gort.y).toEqual 1
  it 'and his facing should be East', ->
    expect(gort.facing).toEqual 'E'
  it 'and he should not be lost', ->
    expect(gort.isLost()).toBeFalsy()

  marvin = kennedy.nextRobot()
  instructions2 = kennedy.nextRobotInstructions()

  it 'when we look at the second robot, Marvin; then we should get a robot at (3,2)', ->
    expect(marvin.x).toEqual 3
    expect(marvin.y).toEqual 2
  it 'and Marvin should be facing North', ->
    expect(marvin.facing).toEqual 'N'
  it 'and his instructions should be FRRFLLFFRRFLL', ->
    expect(instructions2).toEqual 'FRRFLLFFRRFLL'
  it 'when we process the instructions, then Marvin should end up at position (3,3)', ->
    marvin.processInstructions(instructions2, cydonia)
    expect(marvin.x).toEqual 3
    expect(marvin.y).toEqual 3
  it 'and his facing should be North', ->
    expect(marvin.facing).toEqual 'N'
  it 'and he should be lost', ->
    expect(marvin.isLost()).toBeTruthy()

  k9 = kennedy.nextRobot()
  instructions3 = kennedy.nextRobotInstructions()

  it 'when we look at the third robot, K9; then we should get a robot at (0,3)', ->
    expect(k9.x).toEqual 0
    expect(k9.y).toEqual 3
  it 'and K9 should be facing West', ->
    expect(k9.facing).toEqual 'W'
  it 'and his instructions should be LLFFFLFLFL', ->
    expect(instructions3).toEqual 'LLFFFLFLFL'
  it 'when we process the instructions, then K9 should end up at position (2,3)', ->
    k9.processInstructions(instructions3, cydonia)
    expect(k9.x).toEqual 2
    expect(k9.y).toEqual 3
  it 'and his facing should be South', ->
    expect(k9.facing).toEqual 'S'
  it 'and he should not be lost', ->
    expect(k9.isLost()).toBeFalsy()



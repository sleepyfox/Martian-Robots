Robot = (require '../src/Robot').Robot 
Grid = (require '../src/Grid').Grid 

# Helper function
loadFileToArray = (filePath) ->
  fs.readFileSync(filePath).toString().split("\n")

describe 'Given a new robot, Robby, with no paramaters', ->
  it 'when we create a robot without a grid, then we get an error', ->
    try
      robby = new Robot 
      expect(1).toBeNull()
    catch error
      expect(error.message).toEqual "No grid specified"    

describe 'Given a new robot, Robby, with no paramaters', ->
  syrtisMajorPlanum = new Grid 0, 0, 1, 1 
  robby = new Robot syrtisMajorPlanum

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
      robby.processInstructions ""
      expect(1).toBeNull()
    catch error
      expect(error.message).toEqual "Empty robot instruction string"
  it "when given a list of instructions that don't consist solely of [FRL] then we get an error", -> 
    try
      robby.processInstructions "T1000"
      expect(1).toBeNull()
    catch error
      expect(error.message).toEqual "Invalid robot instructions"
  
describe 'Given a 1x1 grid and a two new robots, C3PO and R2D2', ->
  syrtisMajorPlanum = new Grid
  c3po = new Robot syrtisMajorPlanum
  r2d2 = new Robot syrtisMajorPlanum
  key = c3po.moveForward(syrtisMajorPlanum)
  
  it 'when C3PO moves forward, he is lost!', ->
    expect(c3po.isLost()).toBeTruthy()
    expect(key).toBeFalsy()
  it 'and the grid has one dead space', ->
    expect(syrtisMajorPlanum.deadSquares.length).toEqual 1
  it 'and the dead space is at (0,0) facing North', ->
    expect(syrtisMajorPlanum.deadSquares[0]).toEqual "0:0:N"
  it 'when R2D2 moves forward, he is not lost', ->
    key2 = r2d2.moveForward(syrtisMajorPlanum)
    expect(r2d2.isLost()).toBeFalsy()
    expect(key2).toBeNull()
  it 'and his position is unchanged',  ->
    expect(r2d2.x).toEqual 0
    expect(r2d2.y).toEqual 0

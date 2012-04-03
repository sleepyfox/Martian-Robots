Grid = (require '../src/Grid').Grid

describe 'Given a new 1x1 grid (default size)', ->

  syrtisMajorPlanum = new Grid
  
  it 'when we calculate the size then it should be equal to 1', ->
    expect(syrtisMajorPlanum.size).toEqual 1
  it 'when we count the number of dead squares, then there is none', ->
    expect(syrtisMajorPlanum.deadSquares.length).toEqual 0
  for direction in ['N', 'S', 'E', 'W']
    it "when looking for room to move, then there should be no room #{direction}", ->
      expect(syrtisMajorPlanum.ifHasRoomToMove(0, 0, direction)).toBeFalsy()

describe 'Given a new 2x2 grid', ->

  olympusMons = new Grid 1, 1
  # Fitnesse-stylee fixture table 
  dangerWillRobinson = [
                         [0, 0, {N: true, S: false, E: true, W: false}]
                         [0, 1, {N: false, S: true, E: true, W: false}]
                         [1, 0, {N: true, S: false, E: false, W: true}]
                         [1, 1, {N: false, S: true, E: false, W: true}]
                        ]

  it 'when we look at minx & maxx then they should be 0 & 1', ->
    expect([olympusMons.minx, olympusMons.maxx]).toEqual [0, 1]
  it 'when we look at miny & maxy then it should be 0 & 1', ->
    expect([olympusMons.miny, olympusMons.maxy]).toEqual [0, 1]
  it 'when we calculate the size it should be equal to 4', ->
    expect(olympusMons.size).toEqual 4
  it 'when we count the number of dead squares, then there is none', ->
    expect(olympusMons.deadSquares.length).toEqual 0
  for [x, y, directions] in dangerWillRobinson
    for facing, isSafe of directions 
      it "Safe to go #{facing} from (#{x},#{y})? should be #{isSafe}", ->
        expect(olympusMons.ifHasRoomToMove(x, y, facing)).toEqual(isSafe)

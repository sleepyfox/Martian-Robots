robots = require '../src/robots'
Grid = robots.Grid

describe 'Given a new 1x1 grid (default size)', ->

  surface = new Grid
  
  it 'when we calculate the size then it should be equal to 1', ->
    expect(surface.size).toEqual 1
  it 'when we count the number of dead squares, then there is none', ->
    expect(surface.deadSquares.length).toEqual 0
  it 'when looking for room to move, then there should be no room North', ->
    expect(surface.ifHasRoomToMove(0, 0, 'N')).toBeFalsy()
  it 'when looking for room to move, then there should be no room South', ->
    expect(surface.ifHasRoomToMove(0, 0, 'S')).toBeFalsy()
  it 'when looking for room to move, then there should be no room East', ->
    expect(surface.ifHasRoomToMove(0, 0, 'E')).toBeFalsy()
  it 'when looking for room to move, then there should be no room West', ->
    expect(surface.ifHasRoomToMove(0, 0, 'W')).toBeFalsy()

describe 'Given a new 2x2 grid', ->

  surface = new Grid 0, 0, 1, 1

  it 'when we look at minx, then it should be 0', ->
    expect(surface.minx).toEqual 0
  it 'when we look at maxx, then it should be 1', ->
    expect(surface.maxx).toEqual 1
  it 'when we look at miny, then it should be 0', ->
    expect(surface.miny).toEqual 0
  it 'when we look at maxy, then it should be 1', ->
    expect(surface.maxy).toEqual 1
  it 'when we calculate the size it should be equal to 4', ->
    expect(surface.size).toEqual 4
  it 'when we count the number of dead squares, then there is none', ->
    expect(surface.deadSquares.length).toEqual 0
  it 'when looking for room to move North from (0,0), then there should be room', ->
    expect(surface.ifHasRoomToMove(0, 0, 'N')).toBeTruthy()
  it 'when looking for room to move South from (0,0), then there should be no room', ->
    expect(surface.ifHasRoomToMove(0, 0, 'S')).toBeFalsy()
  it 'when looking for room to move East from (0,0), then there should be room', ->
    expect(surface.ifHasRoomToMove(0, 0, 'E')).toBeTruthy()
  it 'when looking for room to move West from (0,0), then there should be no room', ->
    expect(surface.ifHasRoomToMove(0, 0, 'W')).toBeFalsy()
  it 'when looking for room to move North from (1,1), then there should be no room', ->
    expect(surface.ifHasRoomToMove(1, 1, 'N')).toBeFalsy()
  it 'when looking for room to move South from (1,1), then there should be room', ->
    expect(surface.ifHasRoomToMove(1, 1, 'S')).toBeTruthy()
  it 'when looking for room to move East from (1,1), then there should be no room', ->
    expect(surface.ifHasRoomToMove(1, 1, 'E')).toBeFalsy()
  it 'when looking for room to move West from (1,1), then there should be room', ->
    expect(surface.ifHasRoomToMove(1, 1, 'W')).toBeTruthy()


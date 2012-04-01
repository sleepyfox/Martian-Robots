MissionControl = (require '../src/MissionControl').MissionControl

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

describe 'Given an MissionControl and a single line input array', ->
  array = ["5 3"]
  ames = new MissionControl array

  it 'when we interpret this, then we get a 5x3 grid', ->
    expect(ames.longitudeSize).toEqual 5
    expect(ames.latitudeSize).toEqual 3
  it 'when we ask for robot position, then we get an error', ->
    expect(ames.nextRobot).toThrow "No robot specification found"

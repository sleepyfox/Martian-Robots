robots = require '../src/robots'
InputInterpreter = robots.InputInterpreter


describe 'Given an InputInterpreter', ->
  it 'when fed an empty array, then we get an error', ->
    try
      inputInterpreter = new InputInterpreter [] 
      expect("CoffeeScript is great!").toBeNull() # fail fixture if no exception
    catch error
      expect(error).toEqual "Empty input array!"
  it 'when we interpret a line of rubbish then we get an error', ->
    try
      inputInterpreter = new InputInterpreter ["qwerty is great!"]
      expect("Must remember to delete this...").toBeNull() # fail fixture if no exception
    catch error
      expect(error).toEqual "Grid specification invalid"
  it 'when we interpret an initial line that has a non-numeric x coordinate, then we get an error', ->
    try
      inputInterpreter = new InputInterpreter ["one-two 3"]
      expect("Now is the discount of our winter tent").toBeNull() # fail fixture if no exception
    catch error
      expect(error).toEqual "Grid specification invalid"
  it 'when we interpret an initial line that has a non-numeric y coordinate, then we get an error', ->
    try
      inputInterpreter = new InputInterpreter ["1 two-three"]
      expect("Made Gloria Sumner by a ton of pork").toBeNull() # fail fixture if no exception
    catch error
      expect(error).toEqual "Grid specification invalid"
  it 'when we interpret an initial line that has a negative x coordinate, then we get an error', ->
    try
      inputInterpreter = new InputInterpreter ["-1 2"]
      expect("Insert meaningful error message here").toBeNull() # fail fixture if no exception
    catch error
      expect(error).toEqual "longitudeSize out of bounds -1"
  it 'when we interpret an initial line that has a negative y coordinate, then we get an error', ->
    try
      inputInterpreter = new InputInterpreter ["1 -2"]
      expect("Note to self: give up smoking").toBeNull() # fail fixture if no exception
    catch error
      expect(error).toEqual "latitudeSize out of bounds -2"
  it 'when we interpret an initial line that has a x coordinate > 50, then we get an error', ->
    try
      inputInterpreter = new InputInterpreter ["101 2"]
      expect("Insert meaningful error message here").toBeNull() # fail fixture if no exception
    catch error
      expect(error).toEqual "longitudeSize out of bounds 101"
  it 'when we interpret an initial line that has a y coordinate > 50, then we get an error', ->
    try
      inputInterpreter = new InputInterpreter ["1 666"]
      expect("Note to self: give up smoking").toBeNull() # fail fixture if no exception
    catch error
      expect(error).toEqual "latitudeSize out of bounds 666"

describe 'Given an InputInterpreter and a single line input array', ->
  array = ["5 3"]
  inputInterpreter = new InputInterpreter array

  it 'when we interpret this, then we get a 5x3 grid', ->
    expect(inputInterpreter.longitudeSize).toEqual 5
    expect(inputInterpreter.latitudeSize).toEqual 3
  it 'when we ask for robot position, then we get an error', ->
    expect(inputInterpreter.nextRobot).toThrow "No input"

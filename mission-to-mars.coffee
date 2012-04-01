fs = require 'fs'
Robot = (require './src/Robot').Robot 
Grid = (require './src/Grid').Grid 
MissionControl = (require './src/MissionControl').MissionControl

# Helper function
loadFileToArray = (filePath) ->
  fs.readFileSync(filePath).toString().split("\n")

array = []
kennedy = robot = {}
instructions = ""
inputFilePath = "test/problem-test-file.dat"

try
  array = loadFileToArray(inputFilePath)
  kennedy = new MissionControl array.slice() # pass by value
  cydonia = new Grid 0, 0, kennedy.longitudeSize, kennedy.latitudeSize

  robot = kennedy.nextRobot()
  while robot isnt null 
    instructions = kennedy.nextRobotInstructions()
    robot.processInstructions instructions, cydonia 
    isLost = if robot.isLost() then "LOST" else ""
    console.log "#{robot.x} #{robot.y} #{robot.facing} #{isLost}"
    robot = kennedy.nextRobot()
    
catch error
  console.log error.message


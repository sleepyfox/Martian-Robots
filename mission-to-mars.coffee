fs = require 'fs'
Robot = (require './src/Robot').Robot
Grid = (require './src/Grid').Grid
MissionControl = (require './src/MissionControl').MissionControl

array = []
kennedy = robot = {}
instructions = ""
inputFilePath = "test/problem-test-file.dat"

try
  array = fs.readFileSync(inputFilePath).toString().split("\n")
  kennedy = new MissionControl array.slice() # pass by value

  robot = kennedy.nextRobot()
  while robot isnt null
    instructions = kennedy.nextRobotInstructions()
    robot.processInstructions instructions
    isLost = if robot.isLost() then "LOST" else ""
    console.log "#{robot.x} #{robot.y} #{robot.facing} #{isLost}"
    robot = kennedy.nextRobot()
    
catch error
  console.error error.message

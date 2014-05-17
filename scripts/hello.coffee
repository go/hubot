# Description:
#   Test command to develop hubot script
#
# Commands:
#   hubot hello - Reply hello message with your name
#   hubot say key - hubot say registerd ramdom comment
#   hubot reg key value - regist hubot comment
module.exports = (robot) ->
  robot.respond /hello/i, (msg) ->
    msg.send "こんにちわ #{msg.message.user.name} さん!"

  robot.hear /(.*)/i, (msg) ->
    key = msg.match[1]
    if robot.brain.data[key]
      messages = robot.brain.data[key]

      rnd = Math.floor Math.random() * messages.length
      msg.send messages[rnd]

  robot.respond /reg (.*) (.*)/i, (msg) ->
    key = msg.match[1]
 
    if not robot.brain.data[key]
      robot.brain.data[key] = []
 
    robot.brain.data[key].push(msg.match[2])
    robot.brain.save()
 
    msg.send robot.brain.data[key]

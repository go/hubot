# Description:
#   Test command to develop hubot script
#
# Commands:
#   hubot hello - Reply hello message with your name
module.exports = (robot) ->
  robot.respond /hello/i, (msg) ->
    msg.send "こんにちわ #{msg.message.user.name} さん!"

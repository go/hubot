module.exports = (robot) ->
  robot.respond /hello/i, (msg) ->
    msg.send "こんにちわ #{msg.message.user.name} さん!"

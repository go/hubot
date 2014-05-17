module.exports = (robot) ->
  robot.respond /hello/i, (msg) ->
    msg.send "Hello #{msg.message.user.name}"

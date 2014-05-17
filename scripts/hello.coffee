# Description:
#   Test command to develop hubot script
#
# Commands:
#   hubot hello - ユーザー名とともにhelloメッセージを出力します
#   hubot reg <keywords> <message> - 反応するメッセージを登録します
#   hubot unreg <message> - 反応するメッセージを削除します
#   hubot list keywords - 反応するキーワードを出力します
#   hubot list msg <keywords> - 指定キーワードに対してのメッセージを出力します
module.exports = (robot) ->
  robot.respond /hello/i, (msg) ->
    msg.send "こんにちわ #{msg.message.user.name} さん!"

  robot.hear /(.*)/i, (msg) ->
    if not /^hubot/.test(msg.match[1])
      for key in Object.keys(robot.brain.data)
        result = msg.match[1].match(key)

        if result
          messages = robot.brain.data[key]
          rnd = Math.floor Math.random() * messages.length
          msg.send messages[rnd]

#    key = msg.match[1]
#    if robot.brain.data[key]
#      messages = robot.brain.data[key]
#
#      rnd = Math.floor Math.random() * messages.length
#      msg.send messages[rnd]

  robot.respond /reg (.*) (.*)/i, (msg) ->
    key = msg.match[1]
 
    if not robot.brain.data[key]
      robot.brain.data[key] = []
 
    robot.brain.data[key].push(msg.match[2])
    robot.brain.save()
 
    msg.send robot.brain.data[key]

  robot.respond /unreg (.*)/i, (msg) ->
    for key of robot.brain.data
      if msg.match[1] in robot.brain.data[key]
        robot.brain.data[key].pop(msg.match[1])
        msg.send robot.brain.data[key]

    robot.brain.save()

  robot.respond /list keywords/i, (msg) ->
    msg.send Object.keys(robot.brain.data)

  robot.respond /list msg (.*)/i, (msg) ->
    msg.send robot.brain.data[msg.match[1]]

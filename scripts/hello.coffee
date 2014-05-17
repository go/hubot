module.exports = (robot) ->
  robot.respond /hello/i, (msg) ->
    msg.send "こんにちわ #{msg.message.user.name} さん!"

  robot.respond /twitter (.*)/i, (msg) ->
    keyword = encodeURIComponent msg.match[1]
    request = msg.http('http://search.twitter.com/search.json')
                          .query(q: keyword)
                          .get()
    request (err, res, body) ->
      json = JSON.parse body
      msg.send json.results[0].text if json.results.length > 0

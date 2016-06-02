# Description:
#   Returns stock information.
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_WWO_API_URL
#
# Commands:
#   chadbot stock quote <stock> - Get stock information
#
# Notes
#   Request an WWO API KEY in http://finance.yahoo.com/q
#   The url is likely to be something like http://finance.yahoo.com/q
#
#   City parameter can be:
#     stock
#
# Author:
#   EMB
#

wwo_api_url = 'http://finance.google.com/finance/info'

module.exports = (robot) ->
  robot.respond /stock quote (.*)/i, (msg) ->
    msg.http(wwo_api_url)
      .query({
        client: 'ig'
        q: msg.match[1]
      })
      .get() (err, res, body) ->
        try
          result = JSON.parse(body.replace(/\/\//, ''))[0]
          msg.send result.l_cur
        catch error
          msg.send error
          msg.send "Sorry, I couldn't get that stock. Has your API key expired?"

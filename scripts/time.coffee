# Description:
#   Returns local time in given city.
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_WWO_API_KEY
#   HUBOT_WWO_API_URL
#
# Commands:
#   hubot time in <city> - Get current time in city
#
# Notes
#   Request an WWO API KEY in http://www.worldweatheronline.com/
#   The url is likely to be something like http://api.worldweatheronline.com/free/v2/tz.ashx
#
#   City parameter can be:
#     city
#     city, country
#     ip address
#     latitude and longitude (in decimal)
#
# Author:
#   gtoroap
#

wwo_api_key = process.env.HUBOT_WWO_API_KEY
wwo_api_url = process.env.HUBOT_WWO_API_URL or 'http://api.worldweatheronline.com/premium/v1/tz.ashx'

moment = require 'moment'

module.exports = (robot) ->
  robot.respond /time in (.*)/i, (msg) ->
    unless wwo_api_key
      msg.send 'Please, set HUBOT_WWO_API_KEY environment variable'
      return
    unless wwo_api_url
      msg.send 'Please, set HUBOT_WWO_API_URL environment variable'
      return
    msg.http(wwo_api_url)
      .query({
        q: msg.match[1]
        key: wwo_api_key
        format: 'json'
      })
      .get() (err, res, body) ->
        try
          result = JSON.parse(body)['data']
          city = result['request'][0]['query']          
          currentDateTime = moment(result['time_zone'][0]['localtime']).format('h:mm A on dddd, MMM do YYYY')
          msg.send "It's #{currentDateTime} in #{city}"
        catch error
          msg.send error
          msg.send "Sorry, I couldn't get the local time. Has your API key expired?"


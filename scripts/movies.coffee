# Description:
#   Who starred in a movie
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   chadbot who was in <movie name> - give a list of stars in the movie
#
# Author:
#   kevinmhickey


module.exports = (robot) ->
  robot.respond /who was in (.*)/i, (msg) ->
    msg.http("http://www.omdbapi.com")
      .query({
        t: msg.match[1]
        plot: 'short'
        r: 'json'
      })
      .get() (err, res, body) ->
        try
          stars = JSON.parse(body)['Actors']
          msg.send "#{msg.match[1]} starred #{stars}"
        catch error
          msg.send error

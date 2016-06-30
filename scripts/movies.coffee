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
#   hubot who was in <movie name> - give a list of stars in the movie
#   hubot rating for <movie name> - displays the rating from rotten tomatoes
#
# Author:
#   kevinmhickey, svalivarthi


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
  robot.respond /rating for (.*)/i, (msg) ->
    msg.http("http://www.omdbapi.com")
      .query({
        t: msg.match[1]
        plot: 'short'
        r: 'json'
        tomatoes: true
      })
      .get() (err, res, body) ->
        try
          rating = JSON.parse(body)['tomatoUserRating']
          msg.send "#{msg.match[1]} rating #{rating}"
        catch error
          msg.send error

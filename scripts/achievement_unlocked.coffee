# Description:
#   None
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot achievement get|unlocked <achievement> - life goals are in reach
#
# Author:
#   Chris


email = process.env.DEFAULT_EMAIL

module.exports = (robot) ->
  robot.hear /achievement (get|unlock(ed)?(!)?) (.+?)$/i, (msg) ->
    caption = msg.match[4]
    header = 'ACHIEVEMENT UNLOCKED'
    url = "http://achievement-unlocked.herokuapp.com/xbox/#{escape(caption)}?header=#{escape(header)}&email=#{email}.png"
    msg.send(url)
# Description:
#   I'll remember your password for you
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   chadbot my password is <password>
#   chadbot what is my password?
#
# Author:
#   kevinmhickey


module.exports = (robot) ->
  robot.respond /my password is (.*)/i, (res) ->
    robot.brain.set 'secretpassword' + res.envelope.user.name, res.match[1]
    res.reply "I won't tell anyone! "

  robot.respond /what is my password.*/i, (res) ->
    res.reply "The password is " + robot.brain.get 'secretpassword' + res.envelope.user.name

  robot.respond /what is (.*) password.*/i, (res) ->
    res.reply res.match[1] + " uses " + robot.brain.get('secretpassword' + res.match[1]) + " for a password"

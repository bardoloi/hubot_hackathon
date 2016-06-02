# Description:
#   Responds with a private message
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot tell me a secret - tells  you a secret
#
# Author:
#   @bardoloi

module.exports = (robot) ->
	robot.respond /tell me a secret/i, (msg) ->
		msg.send 'whisper whisper whisper'
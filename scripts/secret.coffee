# Description:
#   Responds with a private message

module.exports = (robot) ->
	robot.respond /tell me a secret/i, (msg) ->
		msg.send 'whisper whisper whisper'
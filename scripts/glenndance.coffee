# Description:
#   Bring forth dancing Glenn
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   glenn - Calls in a dancing glenn
#
# Author:
#   solap


module.exports = (robot) ->
  robot.hear /glenn/i, (msg) ->
    msg.send 'http://storage.pardot.com/52582/68569/Napoleon_Glenn_1.gif'

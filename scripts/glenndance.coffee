# Description:
#   Bring forth zombies
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   zombie - Calls in a zombie
#
# Author:
#   solap


module.exports = (robot) ->
  robot.hear /glenn/i, (msg) ->
    msg.send 'http://storage.pardot.com/52582/68569/Napoleon_Glenn_1.gif'

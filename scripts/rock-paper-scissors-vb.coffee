# Description:
#   Emoji all the things
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
# hubot 
# Author:
#   Chadbox


module.exports = (robot) ->
  robot.respond /roshambo challenge @?(.+)/i, (msg) ->
    player1 = msg.message.user.name
    player2 = msg.match[1].trim()

    msg.send "#{player1} challenges #{player2} to a Roshambo game!"
    # gameOn = robot.brain.roshamboGames(player2)
    #   return msg.reply "#{player2} does not exist" unless user?
    #   user.roles or= []

    #   if newRole in user.roles
    #     msg.reply "#{name} already has the '#{newRole}' role."
    #   else
    #     if newRole is 'admin'
    #       msg.reply "Sorry, the 'admin' role can only be defined in the HUBOT_AUTH_ADMIN env variable."
    #     else
    #       myRoles = msg.message.user.roles or []
    #       if msg.message.user.id.toString() in admins
    #         user.roles.push(newRole)
    #         msg.reply "Ok, #{name} has the '#{newRole}' role."

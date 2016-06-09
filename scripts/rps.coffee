# Description:
#   Rock, Paper, Scissor with user vs user
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot rps rock
#
# Author:
#   @emb

choices = [
  'rock'
  'paper'
  'scissors'
]
map = {}

compare = (choice1, choice2) ->
  (map[choice1] or {})[choice2] or -1 # -1 - 'Invalid choice'

choices.forEach (choice, i) ->
  map[choice] = {}
  map[choice][choice] = 1 # 'Was a tie'
  map[choice][choices[(i + 1) % 3]] = 2 # 2 - 'Computer wins'
  map[choice][choices[(i + 2) % 3]] = 3 # 3 - 'User wins'
  return

module.exports = (robot) ->
  robot.respond /rps (.*)/i, (msg) ->
    userChoice = msg.match[1]
    computerChoice = Math.random()
    userWins = robot.brain.get('userWins') || 0
    computerWins = robot.brain.get('computerWins') || 0

    if computerChoice < 0.34
      computerChoice = 'rock'
    else if computerChoice <= 0.67
      computerChoice = 'paper'
    else
      computerChoice = 'scissors'

    res = compare(userChoice, computerChoice)

    switch res
      when -1
        msg.reply 'Invalid choice!'
      when 1
        msg.reply 'Was a tie! You(' + userWins + ') vs Computer(' + computerWins + ')'
      when 2
        msg.reply 'You lost!  You(' + userWins + ') vs Computer(' + (computerWins + 1) + ')'
        robot.brain.set 'computerWins', computerWins + 1
      when 3
        msg.reply 'You win!   You(' + (userWins + 1) + ') vs Computer(' + computerWins + ')'
        robot.brain.set 'userWins', userWins + 1

  robot.respond /rps reset/i, (msg) ->
   robot.brain.set 'computerWins', 0
   robot.brain.set 'userWins', 0
   msg.reply 'All set... let\'s play again!'

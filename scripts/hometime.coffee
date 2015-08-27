# Description:
#   Ask that age old question - Is it hometime yet.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot is it hometime yet - Return the time until we can all go home to our miserable lives.
#
# Author:
#  Richard Lindsay

module.exports = (robot) ->

  robot.respond /is it hometime yet/i, (msg) ->
    homeTime = new Date()
    if msg.envelope.user.name == 'alan'
      homeTime.setHours(17,0,0,0)
    else
      homeTime.setHours(17,30,0,0)

    now = new Date()

    msBetween = Math.abs(homeTime-now) / 1000
    hoursBetween = Math.floor(msBetween / 3600) % 24
    minsBetween = Math.floor(msBetween / 60) % 60
    if now < homeTime
      hours = " #{hoursBetween} hour#{('s' if hoursBetween > 1) ? ''}"
      minutes = " #{minsBetween} minute#{('s' if minsBetween > 1) ? ''}"
      msg.send "Afraid not #{msg.envelope.user.name}, only#{(hours if hoursBetween >= 1) ? ''}#{(minutes if minsBetween != 0) ? ''} to go though!"
    else
      msg.send "http://www.thetimes.co.uk/tto/multimedia/archive/00463/137493760__463465c.jpg"

  robot.respond /hometime help/i, (msg) ->
    msg.send robot.name + ' is it hometime yet - Return the time until we can all go home to our miserable lives :-/'
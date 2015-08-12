# Description:
#   Ask that age old question - Is it hometime yet.
#
# Dependencies:
#   cron
#
# Configuration:
#   None
#
# Commands:
#   hubot is it hometime yet - Return the time until we can all go home to our miserable lives.
#
# Author:
#  Richard Lindsay

cronJob = require('cron').CronJob

module.exports = (robot) ->

  itsHometime = new cronJob('00 30 17 * * 1-5', (->
    robot.messageRoom 'random', 'Get out, It\'s hometime!'
  ), null, true)
  
  robot.respond /is it hometime yet/i, (msg) ->
    homeTime = new Date()
    homeTime.setHours(17,30,0,0)

    now = new Date()

    msBetween = Math.abs(homeTime-now) / 1000
    hoursBetween = Math.floor(msBetween / 3600) % 24
    minsBetween = Math.floor(msBetween / 60) % 60
    if now < homeTime
      hours = " #{hoursBetween} hour#{('s' if hoursBetween > 1) ? ''}"
      minutes = " #{minsBetween} minute#{('s' if minsBetween > 1) ? ''}"
      msg.send "Afraid not, only#{(hours if hoursBetween >= 1) ? ''}#{(minutes if minsBetween != 0) ? ''} to go though!"
    else
      msg.send "http://www.thetimes.co.uk/tto/multimedia/archive/00463/137493760__463465c.jpg"

  robot.respond /hometime help/i, (msg) ->
    msg.send robot.name + ' is it hometime yet - Return the time until we can all go home to our miserable lives :-/'
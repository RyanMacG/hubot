# Description:
#   Ask that age old question - Is it lunchtime yet.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot is it lunchtime yet - Return the answer we all know and love.
#   hubot is it really lunchtime yet  - Return the real time until deliciousness can begin!
#
# Author:
#  Richard Lindsay

module.exports = (robot) ->
  robot.respond /is it hometime yet/i, (msg) ->
    homeTime = new Date()
    homeTime.setHours(17,30,0,0)
    homeTime.setTime(homeTime.getTime()+homeTime.getTimezoneOffset()*60*1000)
    now = new Date()
    now.setTime(now.getTime()+now.getTimezoneOffset()*60*1000)
    msBetween = Math.abs(homeTime-now) / 1000
    hoursBetween = Math.floor(msBetween / 3600) % 24
    minsBetween = Math.floor(msBetween / 60) % 60
    if now < homeTime
      hours = " #{hoursBetween} hour#{('s' if hoursBetween > 1) ? ''}"
      minutes = " #{minsBetween} minute#{('s' if minsBetween > 1) ? ''}"
      msg.send "Afraid not, only#{(hours if hoursBetween >= 1) ? ''}#{(minutes if minsBetween != 0) ? ''} to go though!"
    else
      msg.send "http://www.thetimes.co.uk/tto/multimedia/archive/00463/137493760__463465c.jpg"
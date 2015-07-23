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
  robot.respond /is it (really lunchtime|lunchtime) yet/i, (msg) ->
    now = new Date()
    d = new Date(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(),  now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds())
    d.setHours(12,30,0,0)
    e = new Date(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(),  now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds())
    if msg.match[1] == "really lunchtime"
      msBetween = Math.abs(d-e) / 1000
      hoursBetween = Math.floor(msBetween / 3600) % 24
      minsBetween = Math.floor(msBetween / 60) % 60
      if e < d
        hours = " #{hoursBetween} hour#{('s' if hoursBetween > 1) ? ''}"
        minutes = " #{minsBetween} minute#{('s' if minsBetween > 1) ? ''}"
        msg.send "Afraid not, only#{(hours if hoursBetween >= 1) ? ''}#{(minutes if minsBetween != 0) ? ''} to go though!"
      else
        if hoursBetween < 1
          msg.send "http://www.thetimes.co.uk/tto/multimedia/archive/00463/137493760__463465c.jpg"
         else if hoursBetween >= 1 && hoursBetween < 2
          msg.send "You've just missed it, sorry!"
         else
          msg.send "Erm, lunch was over #{hoursBetween} hours ago. I think you missed it!"
    else
      msg.send "http://www.thetimes.co.uk/tto/multimedia/archive/00463/137493760__463465c.jpg"
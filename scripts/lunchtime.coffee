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
    lunchTimeStart = new Date()
    lunchTimeStart.setHours(12,00,0,0)
    lunchTimeStart.setTime(lunchTimeStart.getTime()+lunchTimeStart.getTimezoneOffset()*60*1000)

    lunchTimeEnd = new Date()
    lunchTimeEnd.setHours(14,00,0,0)
    lunchTimeEnd.setTime(lunchTimeEnd.getTime()+lunchTimeEnd.getTimezoneOffset()*60*1000)
    
    now = new Date()
    now.setTime(now.getTime()+now.getTimezoneOffset()*60*1000)
    
    if msg.match[1] == "really lunchtime"
      if now < lunchTimeStart
        msTill = Math.abs(lunchTimeStart-now) / 1000
        hoursTill = Math.floor(msTill / 3600) % 24
        minsTill = Math.floor(msTill / 60) % 60
        hours = " #{hoursTill} hour#{('s' if hoursTill > 1) ? ''}"
        minutes = " #{minsTill} minute#{('s' if minsTill > 1) ? ''}"
        msg.send "Afraid not, only#{(hours if hoursTill >= 1) ? ''}#{(minutes if minsTill != 0) ? ''} to go though!"
      else if now > lunchTimeStart && now < lunchTimeEnd
        msg.send "/giphy absolutely"
      else
        msSince = Math.abs(now-lunchTimeEnd) / 1000
        hoursSince = Math.floor(msSince / 3600) % 24
        minsSince = Math.floor(msSince / 60) % 60
        hours = " #{hoursSince} hour#{('s' if hoursSince > 1) ? ''}"
        minutes = " #{minsSince} minute#{('s' if minsSince > 1) ? ''}"
        if hoursSince <= 1
          msg.send "You've just missed it, sorry!"
        else
          msg.send "Erm, lunch was over#{(hours if hoursSince > 1) ? ''} ago. I think you missed it!"
    else
      msg.send "http://www.thetimes.co.uk/tto/multimedia/archive/00463/137493760__463465c.jpg"

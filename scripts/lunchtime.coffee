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
#   hubot is it really lunchtime yet - Return the real time until deliciousness can begin!
#
# Author:
#  Richard Lindsay

module.exports = (robot) ->

  robot.respond /is it lunchtime yet/i, (msg) ->
    lunchTimeStart = new Date()
    lunchTimeStart.setHours(12,0,0,0)

    lunchTimeEnd = new Date()
    lunchTimeEnd.setHours(14,0,0,0)

    now = new Date()

    if now < lunchTimeStart
      msTill = Math.abs(lunchTimeStart-now) / 1000
      hoursTill = Math.floor(msTill / 3600) % 24
      minsTill = Math.floor(msTill / 60) % 60
      hours = " #{hoursTill} hour#{('s' if hoursTill > 1) ? ''}"
      minutes = " #{minsTill} minute#{('s' if minsTill > 1) ? ''}"
      msg.send "Afraid not, only#{(hours if hoursTill >= 1) ? ''}#{(minutes if minsTill != 0) ? ''} to go though!"
    else if now > lunchTimeStart && now < lunchTimeEnd
      msg.send "http://media.giphy.com/media/jErnybNlfE1lm/giphy.gif"
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

  robot.respond /can it be lunchtime now/i, (msg) ->
    msg.send "http://www.thetimes.co.uk/tto/multimedia/archive/00463/137493760__463465c.jpg"

  robot.respond /lunchtime help/i, (msg) ->
    message = []
    message.push robot.name + ' is it lunchtime yet - Return time until lunch can commence'
    message.push robot.name + ' can it be lunchtime now - Return the answer you really wanted'
    msg.send message.join('\n')

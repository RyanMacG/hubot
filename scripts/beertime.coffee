# Description:
#   Can we drink yet?
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot is it beer time yet - Return the time until we can have a drink.
#
# Author:
#  Ryan MacGillivray

module.exports = (robot) ->

  robot.respond /is it beer\s?time|can we drink/i, (msg) ->
    beerTime = new Date()
    beerTime.setHours(17,0,0,0)

    now = new Date()

    msBetween = Math.abs(beerTime-now) / 1000
    hoursBetween = Math.floor(msBetween / 3600) % 24
    minsBetween = Math.floor(msBetween / 60) % 60
    if now < beerTime
      hours = " #{hoursBetween} hour#{('s' if hoursBetween > 1) ? ''}"
      minutes = " #{minsBetween} minute#{('s' if minsBetween > 1) ? ''}"
      msg.send "Afraid not #{msg.envelope.user.name}, only#{(hours if hoursBetween >= 1) ? ''}#{(minutes if minsBetween != 0) ? ''} till we can enjoy a drink though!"
    else
      msg.send "https://media.giphy.com/media/SgaZMaG4VPewg/giphy.gif"

  robot.respond /beerTime help/i, (msg) ->
    msg.send robot.name + ' is it beertime/beer time yet - Return the time until we can have a drink'
    msg.send robot.name + ' can we drink yet - Is it time to get our drank on'
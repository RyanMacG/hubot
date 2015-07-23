# Description:
#   Show your pride at being from Falkirk by displaying an image of
#   Eric Joyce whenever 'Falkirk' is mentioned.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#  Richard Lindsay

module.exports = (robot) ->
  robot.hear /falkirk/i, (msg) ->
    msg.send "http://i4.mirror.co.uk/incoming/article4522555.ece/ALTERNATES/s615/Eric-Joyce-MP.jpg"
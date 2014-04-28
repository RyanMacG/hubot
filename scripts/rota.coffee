# Description:
#   Assigning jobs randomly to people with a role
#
# Commands:
#   hubot request <role> - choose a random user with a role
#   hubot rota <role> - show previous assignment counts
#
# Examples:
#   hubot alisdair is a support technician
#   hubot matthew is a support technician
#   hubot request a support technician

module.exports = (robot) ->

  robot.respond /request( an?)? @?([\w .\-]+)\?*$/i, (msg) ->
    role = msg.match[2].trim()

    users = robot.brain.users()
    if not users? or users.length == 0
      msg.send "I don't know about any users."
      return

    eligible = (user) ->
      return false unless user.roles?
      search = new RegExp(role, "i")
      user.roles.some (r) ->
        search.test r

    team = (user for id, user of users when eligible user)

    if team.length == 0
      msg.send "No-one is #{role}"
      return

    winner = team[Math.floor(Math.random() * team.length)]

    winner.rota_stats = winner.rota_stats or { }
    count = winner.rota_stats[role] or 0
    winner.rota_stats[role] = count + 1

    if winner.mention_name?
      name = "@#{winner.mention_name}"
    else
      name = winner.name
    msg.send "#{name} your turn to be #{role}"

  robot.respond /rota @?([\w .\-]+)\?*$/i, (msg) ->
    role = msg.match[1].trim()

    users = robot.brain.users()
    if not users? or users.length == 0
      msg.send "I don't know about any users."
      return

    wins = (user) ->
      return 0 unless user.rota_stats?
      search = new RegExp(role, "i")
      counts = (count for r, count of user.rota_stats when search.test r)
      return 0 if counts.length == 0
      counts.reduce (x,y) -> x + y

    assignments = ("#{user.name}: #{wins(user)}" for id, user of users when wins(user) > 0)

    if assignments.length == 0
      msg.send "no stats for #{role}"
    else
      msg.send "stats for #{role}: #{assignments.join(', ')}"
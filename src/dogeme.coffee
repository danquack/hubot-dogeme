# Description:
#   Wow. Such Doge
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot doge me - Wow. Such Doge
#   hubot <breed> doge me - Wow. Such Doge
#   hubot doge bomb N - Many Doges. Such exploshun
#   hubot <breed> doge bomb N - Many Doges. Such exploshun
#   hubot what doge breeds
#
# Author:
#   rowanmanning
#   danquack


module.exports = (robot) ->
  robot.respond /([a-z]+) doge me/i, (msg) ->
    breed = msg.match[1] || 'error'
    msg.http("https://dogs.vakar.io/breed/#{breed}").get() (err, res, body) ->
        msg.send JSON.parse(body).url

  robot.respond  /doge me$/i, (msg) ->
    msg.http("https://dogs.vakar.io/random")
      .get() (err, res, body) ->
        msg.send JSON.parse(body).url


  robot.respond /doge bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    for x in [1..count]
      msg.http("https://dogs.vakar.io/random")
        .get() (err, res, body) ->
          msg.send JSON.parse(body).url

  robot.respond /([a-z]+) doge bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    breed = msg.match[1]
    for x in [1..count]
      msg.http("https://dogs.vakar.io/breed/#{breed}")
        .get() (err, res, body) ->
          msg.send JSON.parse(body).url

  robot.respond /what doge breeds/i, (msg) ->
    count = msg.match[2] || 5
    breed = msg.match[1]
    for x in [1..count]
      msg.http("https://dogs.vakar.io/breed/")
        .get() (err, res, body) ->
          breeds = JSON.parse(body).breeds
          msg.send breeds.join(", ")

  robot.respond /how many doges?/i, (msg) ->
    msg.http("http://dogeme.rowanmanning.com/count")
      .get() (err, res, body) ->
        msg.send "There are #{JSON.parse(body).doge_count} doges."


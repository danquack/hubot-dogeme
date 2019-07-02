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
#   hubot dog me - Wow. Such Doge
#   hubot <breed> dog me - Wow. Such Doge
#   hubot dog bomb N - Many Doges. Such exploshun
#   hubot <breed> dog bomb N - Many Doges. Such exploshun
#   hubot what dog breeds
#
# Author:
#   rowanmanning
#   danquack


module.exports = (robot) ->
  robot.respond /([a-z]+) dog me/i, (msg) ->
    breed = msg.match[1] || 'error'
    msg.http("https://dogs.vakar.io/breed/#{breed}").get() (err, res, body) ->
        msg.send JSON.parse(body).url

  robot.respond  /dog me$/i, (msg) ->
    msg.http("https://dogs.vakar.io/random")
      .get() (err, res, body) ->
        msg.send JSON.parse(body).url


  robot.respond /dog bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    for x in [1..count]
      msg.http("https://dogs.vakar.io/random")
        .get() (err, res, body) ->
          msg.send JSON.parse(body).url

  robot.respond /([a-z]+) dog bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    breed = msg.match[1]
    for x in [1..count]
      msg.http("https://dogs.vakar.io/breed/#{breed}")
        .get() (err, res, body) ->
          msg.send JSON.parse(body).url

  robot.respond /what dog breeds/i, (msg) ->
    msg.http("https://dogs.vakar.io/breed/")
        .get() (err, res, body) ->
          breeds = JSON.parse(body).breeds
          msg.send breeds.join(", ")


  robot.respond /how many dogs?/i, (msg) ->
    msg.http("http://dogme.rowanmanning.com/count")
      .get() (err, res, body) ->
        msg.send "There are #{JSON.parse(body).dog_count} dogs."


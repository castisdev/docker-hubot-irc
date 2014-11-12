# Description
#   hubot scripts for diagnosing hubot
#
# Commands:
#   hubot 핑 - 퐁을 응답함
#   시간 - 현재 시간을 알려줌
#
# Author:
#   mnpk <mnncat@gmail.com>

module.exports = (robot) ->
  robot.respond /핑/, (msg) ->
    msg.send "퐁"

  robot.hear /시간|몇시야/, (msg) ->
    msg.send "현재 시간: #{new Date()}"

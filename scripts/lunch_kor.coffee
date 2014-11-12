# Description:
#   식당 추천
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   뭐먹을까 - 식당을 골라준다
#   식당추천 <식당이름> - 식당을 추천한다
#   식당 <식당이름> - 식당의 추천 수를 본다
#
# Author:
#   mnpk <mnncat@gmail.com>


module.exports = (robot) ->
  restaurants =  () -> robot.brain.data.restaurants ?= {}

  robot.respond /식당$/, (msg) ->
    for name, like of restaurants()
      msg.send "#{name}: 좋아요 #{like}개"

  robot.respond /식당\s+(.+)$/i, (msg) ->
    name = msg.match[1]
    like = restaurants()[name]
    if like 
      msg.send "#{name}: 좋아요 #{like}개"
    else
      msg.send "처음 듣는 식당입니다."

  robot.respond /식당추천 (.*)$/i ,(msg) ->
    name = msg.match[1]
    like = restaurants()[name]
    if not like
      like = 0
    like += 1
    restaurants()[name] = like
    msg.send "#{name}: 좋아요 #{like}개가 되었습니다."

  robot.respond /뭐\s*먹을까/, (msg) ->
    names = (name for name, like of restaurants())
    name = names[Math.floor(Math.random() * names.length)]
    msg.send "#{name}?"

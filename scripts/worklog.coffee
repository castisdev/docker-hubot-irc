# Description:
#  daily worklog report
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_JIRA_URL
#   HUBOT_JIRA_USER
#   HUBOT_JIRA_PASSWORD
#   HUBOT_EMAIL_USER
#   HUBOT_EMAIL_PASSWORD
#
# Commands:
#   업무보고 - 오늘 당신이 한 일을 요약해서 이메일로 보내드립니다.
#
# Author:
#   mnpk

module.exports = (robot) ->
  get = (msg, where, cb) ->
    httprequest = msg.http(process.env.HUBOT_JIRA_URL + "/rest/api/latest/" + where)
    if (process.env.HUBOT_JIRA_USER)
      authdata = new Buffer(process.env.HUBOT_JIRA_USER+':'+process.env.HUBOT_JIRA_PASSWORD).toString('base64')
      httprequest = httprequest.header('Authorization', 'Basic ' + authdata)
    httprequest.get() (err, res, body) ->
        cb JSON.parse(body)

  today = () ->
    date = new Date()
    return "#{date.getFullYear()}-#{date.getMonth() + 1}-#{date.getDate()}"

  send_worklog_email = (from, title, body) ->
    email = require("emailjs/email")
    server = email.server.connect({
       user: process.env.HUBOT_EMAIL_USER,
       password: process.env.HUBOT_EMAIL_PASSWORD,
       host: "mail.castis.com",
       ssl: false
    });
    server.send({
       text: "#{body}",
       from: "#{from}", 
       to: "<sd7@castis.com>",
       subject: "#{title}"
    }, (err, message) ->
      console.log(err || message))

  robot.hear /업무\s*보고/, (msg) ->
    jql = "updated >= #{today()} AND assignee in (#{msg.message.user.name})"
    get msg, "search/?jql=#{escape(jql)}", (result) ->
      if result.errors?
        return
      if result.total == 0
        return
      summary = "#{msg.message.user.name}님이 오늘 진행하신 이슈입니다.\n"
      msg.send summary
      text = ""
      for issue in result.issues
        text = text + "(#{issue.key}) #{issue.fields.summary}\n"
      msg.send text
      msg.send "업무 보고 이메일을 발송합니다."
      send_worklog_email  "#{result.issues[0].fields.assignee.emailAddress}", "일일업무보고 #{today()}", text

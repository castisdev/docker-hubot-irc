# hubot-irc

Dockerfile for [Hubot](https://hubot.github.com) integrated with our [Slack](https://slack.com) using irc adapter.

### Base Docker Image

- [dockerfile/nodejs](https://registry.hub.docker.com/u/dockerfile/nodejs/)

### Usage

#### Pull

```
$ sudo docker pull castis/hubot-irc
```

#### Run

```
$ sudo docker run -it --rm -p 9009:9009 castis/hubot-irc
```

#### Run as a daemon with env variables

```
$ sudo docker run -d -p 9009:9009 -e HUBOT_JENKINS_AUTH=yourid:password -e HUBOT_IRC_PASSWORD=password castis/hubot-irc
```

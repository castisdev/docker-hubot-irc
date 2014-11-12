# hubot-irc

Dockerfile for [Hubot](https://github.com/github/hubot) integrated with our slack using irc adapter.

### Base Docker Image

- [dockerfile/nodejs](https://registry.hub.docker.com/u/dockerfile/nodejs/)


### Usage

#### Pull

```
$ sudo docker pull castis/hubot-irc
```

#### Build

```
$ sudo docker build -t castis/hubot-irc .
```

#### Run

```
$ sudo docker run -it --rm -p 9009:9009 -e HUBOT_JENKINS_AUTH=yourid:pass castis/hubot-irc
```

#### Run as a damon

```
$ sudo docker run -d -p 9009:9009 -e HUBOT_JENKINS_AUTH=yourid:pass castis/hubot-irc
```

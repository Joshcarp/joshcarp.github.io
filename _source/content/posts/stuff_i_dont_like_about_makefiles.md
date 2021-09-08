---
title: "Stuff I don't like about makefiles"
date: 2020-02-05
draft: true
---
1. Storing everything in a variable:
```
PROTOC = protoc
GIT = git
$(GIT) commit -m "This is silly"
```
makes it unreadable/unmaintainable

2. incorrect abstraction: makefile vs build system

```
service-docker:
  docker-compose up foo
  sleep 10
  docker-compose up bar
```
This means that I can no longer use the `docker-compose` cli; 
I need to interact with it through the makefile. 
For general running purposes that's fine, but what happens when I need to run just one dependency?
1. make serice-docker && docker-compose stop service
2. docker-compose up foo && docker-compose up foobar

I need to replicate the command

in this example this should really be in a health check example of docker-compose. 
This way everything has a single purpose; docker-compose starts up services, and there doesn't need to be two calls to start up a single service.




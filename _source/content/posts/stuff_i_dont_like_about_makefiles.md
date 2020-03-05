---
title: "Stuff I don't like about makefiles"
date: 2020-02-05
---
1. Storing everything in a variable:
```
PROTOC = protoc
GIT = git
$(GIT) commit -m "This is silly"
```



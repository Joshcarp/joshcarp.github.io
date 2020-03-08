---
title: "Stuff I encountered when working with go modules"
date: 2020-02-05
---

1. `go get` within a mod is different inside a module vs outside; local installation vs project go.mod 

2. go.sum database of hashes; goprivate telling go to go direct

3. Import paths; inside vs outside; everything is absolute


So I was wondering what the deal with is with how go modules handle git tags, and what happens when a git repo doesn't have any git releases/tags. 

first, make a repo with a simple go program:

```
package main 

func main(){
	println("First push")
}
```

now push `git add main.go && git commit -m "First commit" && go push`

Now go getting the package in another directory `go get github.com/joshcarp/go-get-test`

`go-get-test` --> "First push"

Now update the code:


```
package main 

func main(){
	println("Second push")
}
```

repeat the process of pushing and getting in another directory:
`go-get-test` --> "Second push"

Now we're going to tag a release:





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
--> go: downloading github.com/joshcarp/go-get-test v0.0.0-20200308062213-d13770e2c452
`go-get-test` --> "First push"

Now update the code:


```
package main 

func main(){
	println("Second push")
}
```

repeat the process of pushing and getting in another directory:
`go get github.com/joshcarp/go-get-test`
``` 
go: downloading github.com/joshcarp/go-get-test v0.0.0-20200308062213-d13770e2c452
go: github.com/joshcarp/go-get-test upgrade => v0.0.0-20200308062213-d13770e2c452
```
We can see that we've updated our package

`go-get-test` --> "Second push"

Now we're going to tag a release:

`git tag -a v0.0.1 -m "First Tag"`

`git push` 

`git push -u origin v0.0.1`

Now once we get our repo we should see a git tag:
`go get github.com/joshcarp/go-get-test`


```
go: downloading github.com/joshcarp/go-get-test v0.0.1
go: github.com/joshcarp/go-get-test upgrade => v0.0.1
```

Now changing the code again
```
package main 

func main(){
	println("After Tag")
}
```

and committing and pushing ... 

Now we'll try to get our repo in another directory: 

```
go get -u github.com/joshcarp/go-get-test
go: github.com/joshcarp/go-get-test upgrade => v0.0.1
```
We can see our repo hasn't updated at all
Likewise, when we run our code:
```
> go-get-test
Second push

```
we only get our old tagged commit. 

For whatever reason this seems obvious; go gets the latest commit if there aren't any tags, and only gets the latest tag (even if there are later commits. 

I've always had in my mind that "go get always gets the latest commit"; so for a while when I was prototyping repos i'd waste a whole bunch of time tagging and pushing then getting in another repo, instead I can just forget about tagging alltogether. 

That brings us to another interesting hypothesis; what if I delete a tag:

`git push --delete origin v0.0.2`

now when we try and `go get` our repo:

`go get -u -v github.com/joshcarp/go-get-test`

-> `go: github.com/joshcarp/go-get-test upgrade => v0.0.2`
but wait, didn't we delete this repo?
maybe it's just getting it locally?
-> `rm -rf <all the local go-get-test caches>` 

but still:
```
go get -u -v github.com/joshcarp/go-get-test       
go: github.com/joshcarp/go-get-test upgrade => v0.0.2
> go-get-test
After Tag
```
Hmm, so it seems like we can't downgrade the latest tagged version once it's on go.sum (this is a database of all the public hash sums of the code in order to be able to do effective version control)





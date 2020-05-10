---
title: "Go PR checklist"
date: 2020-05-10
---

1. Don't stutter with naming exported identifiers

```go
printer.Module()
```
is better than
```go
printer.PrintModule()
```

2. Try to return early

```go
if !contition{
    return 
}
for _, e := range whatever{
    if e == foo{
        bar()
    }
}

```

is better than

```go
if contition{
    for _, e := range whatever{
        if e == foo{
            return
        }
    }
}
```

3. Identify common repeated methods and replace with interfaces

```go

func ApplicationAttribute(app *sysl.Application){
    	if description := app.GetAttrs()["description"]; description != nil {
		return description.GetS()
	}
	return ""
}

func TypeAttribute(t *sysl.Type){
    	if description := t.GetAttrs()["description"]; description != nil {
		return description.GetS()
	}
	return ""
}

```

both these functions can be replaced with

```go
type Attr interface {
	GetAttrs() map[string]*sysl.Attribute
}

func Attribute(a Attr, query string) string {
	if description := a.GetAttrs()[query]; description != nil {
		return description.GetS()
	}
	return ""
}
```

4. Don't go crazy with structs

- Having more verbose functions are, in my opinion, more understandable than having a reciever that doesn't do anything

```go
type UnneededStruct struct{
    w io.Writer
    anotherConstant interface{}
}

func NewUnneededStruct(w io.Writer, anotherConstant interface{})UnneededStruct{
    // some logic here
    return &UnneededStruct{
        w: w
        anotherConstant: anotherConstant
    }
}

func (u *UnneededStruct)FinallyAFunction(whatever string){
    // at this point the logic here doesn't actually matter, you get the point
}

```

Replace this with the function without any recievers

```go

func FinallyAFunction(w io.Writer, anotherConstant interface{}, whatever string){
    // at this point the logic here doesn't actually matter, you get the point
}

```

5. Use reflect when you need to sort a list of maps
- If you've got a `map[Type]*<anything>` you can't use `map[Type]*interface{}` or `map[Type]interface{}`, as pointer recievers don't fulfil interface, so you need to use just an `interface{}` and then `reflect.ValueOf(m).MapKeys()`

```go
func SortedKeys(m interface{}) []string {
	keys := reflect.ValueOf(m).MapKeys()
	ret := make([]string, 0, len(keys))
	for _, v := range keys {
		ret = append(ret, v.String())
	}
	sort.Strings(ret)
	return ret
}
```
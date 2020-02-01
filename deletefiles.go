package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os/exec"
)

var keep = []string{"CNAME", "deploy.sh", "_source", ".git", "deletefiles.go"}

func main() {
	files, err := ioutil.ReadDir("./")
	if err != nil {
		log.Fatal(err)
	}

	for _, f := range files {
		if !contains(keep, f.Name()) {
			fmt.Println("removing", f.Name())
			fmt.Println(exec.Command("rm", "-r", f.Name()).Output())

		}
	}
}

func contains(s []string, e string) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}

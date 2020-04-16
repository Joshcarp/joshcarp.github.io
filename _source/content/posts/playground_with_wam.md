---
title: "Making a playground with wasm"
date: 2020-02-05
draft: true
---

1. GOOS=js GOARCH=wasm go1.12.4 build -o static/main.wasm main.go

 cp /usr/local/go/misc/wasm/wasm_exec.js .
 This needs to be from the same go installation that compiled the go wasm file
 
 now to test, we can use a node command
 
 node wasm_exec.js wasm/arrai eval '41 + 1'
 
 

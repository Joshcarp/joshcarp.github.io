all: clean deploy

clean:
	go run deletefiles.go
deploy:
	./deploy.sh
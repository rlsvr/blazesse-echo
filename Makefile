.PHONY: all test lint

all: test lint

test:
	go test -race -v ./...

lint:
	golangci-lint run ./...

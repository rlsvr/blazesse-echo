.PHONY: all test lint vulncheck

all: test lint

test:
	go test -race -v ./...

lint:
	golangci-lint run ./...

## vulncheck: run govulncheck on all packages
vulncheck:
	go run golang.org/x/vuln/cmd/govulncheck@latest ./...

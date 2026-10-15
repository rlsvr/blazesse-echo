# blazesse-echo

[![Go Reference](https://pkg.go.dev/badge/github.com/rlsvr/blazesse-echo.svg)](https://pkg.go.dev/github.com/rlsvr/blazesse-echo)
[![CI](https://github.com/rlsvr/blazesse-echo/actions/workflows/ci.yml/badge.svg)](https://github.com/rlsvr/blazesse-echo/actions/workflows/ci.yml)
[![golangci-lint](https://img.shields.io/badge/golangci--lint-passing-brightgreen?logo=go)](https://github.com/rlsvr/blazesse-echo/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Echo web framework adapter for [`blazesse`](https://github.com/rlsvr/blazesse), the ultra-high-throughput, zero-allocation Server-Sent Events (SSE) toolkit for Go.

## Installation

```bash
go get github.com/rlsvr/blazesse-echo
```

## Usage

```go
package main

import (
	"github.com/labstack/echo/v4"
	"github.com/rlsvr/blazesse"
	blazesseEcho "github.com/rlsvr/blazesse-echo"
)

func main() {
	e := echo.New()
	b := blazesse.NewBroadcaster()
	defer b.Close()

	// 1. Mount broadcaster directly as an Echo route
	e.GET("/events", blazesseEcho.Handler(b))

	// 2. Or upgrade 1-to-1 within an Echo handler
	e.GET("/stream", func(c echo.Context) error {
		stream, err := blazesseEcho.Upgrade(c)
		if err != nil {
			return err
		}
		defer stream.Close()

		return stream.Send(blazesse.TextFrame("hello world"))
	})

	e.Logger.Fatal(e.Start(":8080"))
}
```

## License

MIT

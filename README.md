# go-linters

Run a select set of the gometalinter's linters against a go codebase

Vendored packages are not linted, by default.

### Build
	make image
    
### Run
	make run

	# or...

	docker run --rm -v ${GOPATH}/src/${PACKAGE}:/go/src/${PACKAGE} -e GO_GET=$(GO_GET) -w /go/src/${PACKAGE} glynhanmer/go-linters

Set the `PACKAGE` environment variable when running `make run`

If you are running the linters against a package, the dependencies can be "go get"-ted by setting the environment variable `GO_GET` to `1`. Inside the `go-linters` container, `go get` will be ran.

The `go-linters` container will exit with a non-zero code on failure

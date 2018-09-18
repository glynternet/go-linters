# go-linters

Run a select set of the gometalinter's linters against a go codebase

Vendored packages are not linted, by default.

### Build
	make image
    
### Run
	make run

	# or...

	docker run --rm -v ${GOPATH}/src/${PACKAGE}:/go/src/${PACKAGE} -w /go/src/${PACKAGE} glynhanmer/go-linters

Set the `PACKAGE` environment variable when running `make run`

If you are running the linters against a package, the dependencies can be "go get"-ted by setting the environment variable `GO_GET` to `1`. Inside the `go-linters` container, `go get` will be ran.

The `go-linters` container will exit with a non-zero code on failure

#### Environment Variables
- `GO_GET` (default=0)  
Set `GO_GET` to `1` to have the container run `go get` before running the linters.
- `CONCURRENCY` (default=4)  
Set to a value to change the number of concurrent linters that the gometalinter runs inside the container.
ARG GOLANG_BUILDER_TAG
FROM golang:${GOLANG_BUILDER_TAG} as builder

RUN apk add --no-cache git

# Install gometalinter
RUN go get -u gopkg.in/alecthomas/gometalinter.v2 \
	&& gometalinter.v2 --install \
	&& mv /go/bin/* /usr/local/bin/ \
	&& rm -rf /go/pkg /go/*/*

# Get app dependencies and run gometalinter
CMD if [ "$GO_GET" = "1" ]; then go get -v -t ./... ; fi && \
    CGO_ENABLED=0 gometalinter.v2 --vendor --tests \
    --concurrency=${CONCURRENCY:-4} \
    --deadline=5m \
    --exclude=bindata.go \
    --exclude=.pb.go \
    --disable-all \
    --enable=deadcode \
    --enable=errcheck \
    --enable=gocyclo \
    --enable=goimports \
    --enable=golint \
    --exclude='which can be annoying to use \(golint\)' \
    --enable=lll --line-length=120 \
    --exclude='_test.go:.+\(lll\)' \
    --enable=vet \
    --enable=ineffassign \
    --enable=staticcheck \
    --enable=structcheck \
    --enable=unconvert \
    --enable=unused \
    --enable=varcheck \
    ./...

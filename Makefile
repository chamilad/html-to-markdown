# Makefile
BINARY="html-to-markdown"
TARGET="build"
VERSION="v0.1"

export GO111MODULE=on
LDFLAGS=-ldflags "-extldflags '-static' -s -w"

.DEFAULT_GOAL: $(BINARY)

$(BINARY): test
	mkdir -p ${TARGET}
	env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build ${LDFLAGS} -a -o ${TARGET}/${BINARY}
	chmod +x ${TARGET}/${BINARY}

test: clean
	go test ./...

release: clean
	mkdir -p ${TARGET}/release
	env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build ${LDFLAGS} -a -o ${TARGET}/release/${BINARY}-${VERSION}-linux-amd64
	env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build ${LDFLAGS} -a -o ${TARGET}/release/${BINARY}-${VERSION}-win-amd64
	env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build ${LDFLAGS} -a -o ${TARGET}/release/${BINARY}-${VERSION}-darwin-amd64
	chmod -R +x ${TARGET}/release

clean:
	go clean
	rm -rf ${TARGET}


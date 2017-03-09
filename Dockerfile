# Official document say: Install Go1.6.
# https://github.com/golang/gddo/wiki/Development-Environment-Setup
FROM golang:1.8-alpine

RUN apk --update --no-cache add git && \
	go get github.com/golang/gddo/gddo-server && \
	go install github.com/golang/gddo/gddo-server && \
	apk del git

EXPOSE 8080

CMD /go/bin/gddo-server -db-server=$REDIS_URL

FROM golang:1.6-alpine

RUN apk --update --no-cache add git && \
	go get github.com/golang/gddo/gddo-server && \
	go install github.com/golang/gddo/gddo-server

EXPOSE 8080

CMD /go/bin/gddo-server -db-server=$REDIS_URL

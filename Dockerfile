FROM golang:1.8-alpine

RUN apk --update --no-cache add git python && \
	go get github.com/golang/gddo/gddo-server && \
	wget http://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-137.0.1-linux-x86_64.tar.gz -O /google-cloud-sdk.tar.gz && \
	cd / && tar xzvf google-cloud-sdk.tar.gz && \
	yes | /google-cloud-sdk/install.sh && \
	/google-cloud-sdk/bin/gcloud components install app-engine-python && \
	sed -ie 's/"redis:\/\/127\.0\.0\.1:6379"/os.Getenv("REDIS_URL")/' /go/src/github.com/golang/gddo/database/database.go && \
	apk del git && rm -f /google-cloud-sdk.tar.gz

ADD run.sh /run.sh

EXPOSE 8080

CMD /run.sh

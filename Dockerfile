FROM alpine:latest

RUN apk add aws-cli
WORKDIR /tmp/app
COPY finder.sh /tmp/app
CMD sh /tmp/app/finder.sh

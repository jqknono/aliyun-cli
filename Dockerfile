# build aliyun-cli (aliyun)
FROM golang:alpine as builder
ADD . src/github.com/aliyun/aliyun-cli/
WORKDIR /go/src/github.com/aliyun/aliyun-cli
RUN apk add --update make git;\
  make deps; \
  make testdeps; \
  make build;

# build aliyun image from alpine
FROM alpine
COPY --from=builder /go/src/github.com/aliyun/aliyun-cli/out/aliyun /usr/local/bin
CMD ["aliyun"]
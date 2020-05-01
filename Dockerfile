# Start by building the application.
FROM golang:1.13 as build

WORKDIR /go/src/app
ADD . /go/src/app

RUN go get -d -v ./...

RUN go build -o /go/bin/app

# Now copy it into our base image.
# FROM reg-hk.agodadev.io/infra/infra-centos7
FROM golang:1.12
# FROM golang:1.14.2-buster
# FROM gcr.io/distroless/base-debian10
COPY --from=build /go/bin/app /
CMD ["/app"]

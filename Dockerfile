# Start by building the application.
FROM golang:1.14.7 as build

WORKDIR /go/src/app
ADD . /go/src/app

RUN go get -d -v ./...

RUN go build -o /go/bin/app

# Now copy it into our base image.
FROM golang:1.14.7

COPY --from=build /go/bin/app /
CMD ["/app"]

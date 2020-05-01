############################
# STEP 1 build executable binary
############################
# golang debian buster 1.13.6 linux/amd64
# https://github.com/docker-library/golang/blob/master/1.13/buster/Dockerfile

FROM golang@sha256:93a56423351235e070b3630e0a8b3e27d5e868883d4dff591f676315f208a574 AS builder

WORKDIR /go/src/app
COPY . /go/src/app

RUN go get -d -v ./...
RUN go build -o /go/bin/app

############################
# STEP 2 build the image
############################

FROM golang:1.12

# Copy our static executable
COPY --from=builder /go/bin/app /app
WORKDIR /

# Run the hello binary.
CMD ["/app"]

LABEL Name=app-demo Version=0.0.1
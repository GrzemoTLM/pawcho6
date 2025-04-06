# syntax=docker/dockerfile:1.4

FROM alpine AS git-clone
RUN apk add --no-cache git openssh

WORKDIR /repo

RUN mkdir -p ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN --mount=type=ssh \
    git clone git@github.com:GrzemoTLM/pawcho6.git .
FROM golang:alpine AS build
WORKDIR /src
COPY --from=git-clone /repo /src
RUN go build -ldflags "-X main.version=1.0.0" -o /bin/app


FROM alpine
COPY --from=build /bin/app /bin/app
ENTRYPOINT ["/bin/app"]


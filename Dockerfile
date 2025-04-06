FROM golang:1.21-alpine AS builder

ARG VERSION
ENV VERSION=${VERSION}

WORKDIR /app
COPY . .

RUN go build -ldflags="-X main.version=${VERSION}" -o app

FROM scratch
COPY --from=builder /app/app /app
ENTRYPOINT ["/app"]


# base go image
FROM golang:1.21.3-alpine as builder

RUN mkdir "app"

COPY ../broker-service/. /app

WORKDIR /app

RUN CGO_ENABLED=0 go build -o brokerApp ./cmd/api

RUN chmod +x ./brokerApp


# build a tiny docker image
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/brokerApp /app/brokerApp

CMD ["/app/brokerApp"]

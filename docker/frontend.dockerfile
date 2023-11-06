# base go image
FROM golang:1.21.3-alpine as builder

RUN mkdir "app"

COPY ../front-end/. /app

WORKDIR /app

RUN CGO_ENABLED=0 go build -o frontend ./cmd/web

RUN chmod +x ./frontend


# build a tiny docker image
FROM alpine:latest

WORKDIR /app
COPY --from=builder /app/cmd/ /app/cmd
COPY --from=builder /app/frontend /app/frontend

CMD ["/app/frontend"]

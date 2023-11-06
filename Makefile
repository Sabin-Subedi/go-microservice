FRONT_END_BINARY=frontend
BROKER_BINARY=brokerApp

## up: starts all the containers in the background without forcing build
up:
	@echo "Starting containers..."
	docker compose up -d
	@echo "Containers started"

## up_build: starts all the containers in the background forcing build
up_build:
	@echo "stopping docker images (if any)"
	docker compose down
	@echo "Starting containers..."
	docker compose up -d --build
	@echo "Containers started"

## down: stops all the containers
down:
	@echo "Stopping containers..."
	docker compose down
	@echo "Containers stopped"

## build_broker: builds the broker binary
build_broker:
	@echo "Building broker..."
	cd broker-service && env GOOS=linux CGO_ENABLED=0 go build -o ../$(BROKER_BINARY) ./cmd/api
	@echo "Broker built"

## build_frontend: build the frontend binary
build_frontend:
	@echo "Building frontend..."
	cd frontend && env GOOS=linux CGO_ENABLED=0 go build -o ../$(FRONT_END_BINARY) ./cmd/api
	@echo "Frontend built"

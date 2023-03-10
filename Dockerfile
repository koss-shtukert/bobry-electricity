############################
# STEP 1 build executable binary
############################
FROM golang:1.20-alpine as builder

WORKDIR /
COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./bin/main main.go

############################
# STEP 2 build a small image
############################
FROM ubuntu:latest

WORKDIR /app

# Copy only required files to final docker image
COPY --from=builder /bin/main /app/bin/main

RUN chmod +x /app/bin/main

EXPOSE 8085

CMD ["/app/bin/main"]
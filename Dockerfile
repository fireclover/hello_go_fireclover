# Create build stage based on buster image
FROM golang:latest AS builder

# Create working directory under /app
WORKDIR /app

# Copy over all go config (go.mod, go.sum etc.)
COPY go.* ./

# Install any required modules
RUN go mod download

# Copy over Go source code
COPY *.go ./

# Run the Go build and output binary under hello_go_http
RUN go build -o /hello_go_fireclover

# Create a new release build stage
FROM gcr.io/distroless/base

# Set the working directory to the root directory path
WORKDIR /

# Copy over the binary built from the previous stage
COPY --from=builder /hello_go_fireclover /hello_go_fireclover

RUN echo 'Who run the world? Girls!'

# Make sure to expose the port the HTTP server is using
EXPOSE 3000 22

# Run the app binary when we run the container
ENTRYPOINT ["/hello_go_fireclover"]

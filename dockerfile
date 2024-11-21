/github/workspace/shortener/Dockerfile
FROM golang:alpine AS builder

WORKDIR /app

COPY ./vendor ./vendor
COPY ./cmd ./cmd
COPY ./internal ./internal
COPY ./pkg ./pkg
COPY ./go.mod ./go.mod
COPY ./go.sum ./go.sum

RUN go build -o shortener ./cmd/shortener

FROM alpine

ENV PORT=8080
EXPOSE ${PORT}

WORKDIR /app

COPY --from=builder /app/shortener ./shortener

CMD ["./shortener"]
```
```markdown
/github/workspace/shortener/README.md
# Dockerfile for Shortener Application

This Dockerfile defines the multi-stage build process needed to containerize the Shortener application using Alpine Linux as the base image for a small footprint.

## Build Stages:

### Builder Stage:
- Starts from the `golang:alpine` image to leverage the Go compiler.
- Sets the working directory to `/app` within the image.
- Copies the application source code and its dependencies into the image.
- Compiles the application using `go build`, resulting in a binary named `shortener`.

### Final Stage:
- Starts from a vanilla Alpine Linux image to minimize size.
- Sets the working directory to `/app`.
- Copies the compiled `shortener` binary from the builder stage into the final image.
- Sets the `PORT` environment variable to `8080`, which the application listens on. If a different port is desired, pass it as an environment variable during the container run.
- Exposes the port defined in the `PORT` environment variable to be accessible on the host.

## Running the container:
To run the Shortener application:

```bash
docker run -dp 8080:8080 your-docker-image
```

Substitute `your-docker-image` with the image name you choose. The `-dp` flag detaches the container and maps port `8080` from the host to the container.

Make sure all necessary configurations, including database access, are correctly set up in the `config.yaml` file or through environment variables.
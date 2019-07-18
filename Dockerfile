FROM golang:1.12-stretch AS build
ADD . /src
WORKDIR /src
RUN go mod download
RUN CGO_ENABLED=0 go build -tags netgo -installsuffix netgo -ldflags "-s -w"

FROM alpine:latest
COPY --from=build /src/easy-novnc /
EXPOSE 8080
ENTRYPOINT ["/easy-novnc"]
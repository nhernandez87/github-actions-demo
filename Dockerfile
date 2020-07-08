FROM golang:alpine
#COPY ./src /go/src/app
ADD ./src /go/src/app
WORKDIR /go/src/app
ENV PORT=3001
CMD ["go", "run", "main.go"]

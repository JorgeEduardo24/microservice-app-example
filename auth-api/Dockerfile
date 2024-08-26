FROM golang:1.9-alpine

WORKDIR /go/src/app

EXPOSE 8000

# Define environment variables for JWT_SECRET, AUTH_API_PORT, and USERS_API_ADDRESS
ENV ZIPKIN_URL=http://zipkin:9411/api/v2/spans
ENV JWT_SECRET=PRFT
ENV AUTH_API_PORT=8000
ENV USERS_API_ADDRESS=http://user-container:8083


RUN apk --no-cache add curl git && \
    curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

COPY . .

RUN dep ensure

RUN go build -o auth-api

CMD /go/src/app/auth-api

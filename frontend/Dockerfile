FROM node:8.17.0


EXPOSE 8080

ENV ZIPKIN_URL=http://zipkin:9411/api/v2/spans
ENV PORT=8080
ENV AUTH_API_ADDRESS=http://auth-container:8000
ENV TODOS_API_ADDRESS=http://todos-container:8082
 
WORKDIR /usr/src/app

COPY package.json ./
RUN npm install

COPY . .

CMD ["sh", "-c", "npm start" ]

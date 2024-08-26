#Usar una imagen base oficial de Node.js versión 8.17.0
FROM node:8.17.0

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar package.json y package-lock.json para instalar dependencias
COPY package*.json ./

# Instalar las dependencias necesarias
RUN npm install --no-cache

# Copiar el resto de los archivos de la aplicación al contenedor
COPY . .

# Establecer las variables de entorno requeridas
ENV TODO_API_PORT=8082
ENV JWT_SECRET=PRFT
ENV REDIS_HOST=redis
ENV REDIS_PORT=6379
ENV REDIS_CHANNEL=log_channel
ENV ZIPKIN_URL=http://zipkin:9411/api/v2/spans

# Exponer el puerto que usa la API
EXPOSE ${TODO_API_PORT}

# Comando para ejecutar la aplicación
CMD ["npm", "start"]


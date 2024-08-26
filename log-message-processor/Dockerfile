# Usar una imagen base oficial de Python 3.6
FROM python:3.6

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar los archivos de requirements.txt y main.py al contenedor
COPY requirements.txt .

# Instalar las dependencias necesarias
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto de los archivos de la aplicación al contenedor
COPY . .

EXPOSE 6029

# Establecer las variables de entorno requeridas
ENV REDIS_HOST=redis
ENV REDIS_PORT=6379
ENV REDIS_CHANNEL=log-channel

# Comando para ejecutar la aplicación
CMD ["python3", "main.py"]


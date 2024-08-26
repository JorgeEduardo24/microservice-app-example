# Microservice App 

Este proyecto es una aplicación básica de TODO diseñada con una arquitectura de microservicios. Aunque es una aplicación sencilla, es interesante porque los microservicios que la componen están escritos en diferentes lenguajes de programación o frameworks (Go, Python, Vue, Java y NodeJS). Con este diseño, experimentarás con múltiples herramientas de construcción y entornos.

## Descripción General de la Arquitectura
La aplicación se divide en varios microservicios, cada uno responsable de una función específica. A continuación, se presenta una descripción general de la arquitectura:

<!-- Añade la ruta a tu imagen de la arquitectura aquí -->

1. Frontend: Aplicación en Vue.js que proporciona la interfaz de usuario.

2. API de Autenticación: Aplicación en Go que proporciona funcionalidad de autenticación utilizando tokens JWT.

3. API de Usuarios: Aplicación en Spring Boot que maneja los perfiles de usuario.

4. API de TODOs: Aplicación en Node.js que gestiona las operaciones CRUD para los elementos TODO y registra las operaciones en una cola Redis.

5. Procesador de Mensajes de Registro: Aplicación en Python que procesa los registros de la cola Redis.

6. Cola Redis: Gestiona las colas de mensajes para la API de TODOs y el Procesador de Mensajes de Registro.

7. Herramientas de Monitoreo: Herramientas integradas como Prometheus, cAdvisor y Grafana para el monitoreo de contenedores.

## Componentes
1. API de Usuarios:

* Framework: Spring Boot
* Funcionalidad: Proporciona perfiles de usuario, permitiendo la recuperación de todos los usuarios o de un usuario específico por nombre de usuario.
* Imagen Docker: users-image:0.1.0

2. API de Autenticación:
* Lenguaje: Go
* Funcionalidad: Proporciona servicios de autenticación y genera tokens JWT para ser utilizados con otras APIs.
* Imagen Docker: auth-image:0.1.0

3. API de TODOs:
* Lenguaje: Node.js
* Funcionalidad: Gestiona operaciones CRUD en los elementos TODO y registra las operaciones "crear" y "eliminar" en una cola Redis.
* Imagen Docker: todos-image:0.1.0

4. Procesador de Mensajes de Registro:
* Lenguaje: Python
* Funcionalidad: Procesa mensajes de registro desde la cola Redis y los imprime en la salida estándar.

5. Imagen Docker: log-message-image:0.1.0
Frontend
* Framework: Vue.js
* Funcionalidad: Proporciona la interfaz de usuario para interactuar con los TODOs y los perfiles de usuario.
* Imagen Docker: frontend-image:0.1.0

## Configuración
Creación de las Imágenes Docker

Para automatizar la creación de las imágenes Docker para cada microservicio, se creó un script bash: 

``` 
cd users-api/
docker build -t users-image:0.1.0 .
cd .. 
cd auth-api/
docker build -t auth-image:0.1.0 .
cd ..
cd frontend/
docker build -t frontend-image:0.1.0 .
cd ..
cd todos-api/
docker build -t todos-image:0.1.0 .
cd ..
cd log-message-processor/
docker build -t log-message-image:0.1.0 .
cd ..
cd prometheus/
clear
```

Ejecución de las imágenes de docker

Para ejecutar los contenedores en el orden correcto, asegurando que todas las dependencias estén resueltas, se creó otro script bash:
``` 
docker run -d --name zipkin --network distribuidos -p 9411:9411 openzipkin/zipkin
docker run -d -p 6379:6379 --network distribuidos --name redis redis
docker run -d -p 8083:8083 --network distribuidos --name user-container users-image:0.1.0
docker run -d -p 8000:8000 --network distribuidos --name auth-container auth-image:0.1.0
docker run -d -p 8080:8080 --network distribuidos --name front-container frontend-image:0.1.0
docker run -d -p 8082:8082 --network distribuidos --name todos-container todos-image:0.1.0
docker run -d -p 6060:6060 --network distribuidos --name log-message-container log-message-image:0.1.0

docker run -d --name cadvisor --network distribuidos -p 8090:8080 \
-v /:/rootfs:ro \
-v /var/run:/var/run:rw \
-v /sys:/sys:ro \
-v /var/lib/docker/:/var/lib/docker:ro \
gcr.io/cadvisor/cadvisor:latest

docker run -d --name prometheus --network distribuidos -p 9090:9090 -v ./prometheus.yml:/etc/prometheus/prometheus.yml:ro prom/prometheus:latest --config.file=/etc/prometheus/prometheus.yml

docker run -d -p 3000:3000 \
--name=grafana \
--network=distribuidos \
grafana/grafana

``` 

## Monitoreo
Para monitorear la aplicación, utilizamos las siguientes herramientas:

1. cAdvisor: Monitorea el uso de recursos y las características de rendimiento de los contenedores en ejecución.

2. Prometheus: Recoge métricas de cAdvisor.

3. Grafana: Visualiza las métricas recogidas por Prometheus.

Todas estas herramientas se ejecutan como contenedores Docker y se pueden configurar utilizando los scripts bash proporcionados.

## Configuración de red y puertos
Cada servicio se ejecuta en un contenedor Docker conectado a una red llamada distribuidos. A continuación se presentan los servicios con sus respectivos puertos:

| Servicio              | Nombre del Contenedor Docker | Puerto |
|-----------------------|------------------------------|--------|
| API de Usuarios       | user-container               | 8083   |
| API de Autenticación  | auth-container               | 8000   |
| Frontend              | front-container              | 8080   |
| API de TODOs          | todos-container              | 8082   |
| Procesador de Mensajes | log-message-container        | 6060   |
| Cola Redis            | redis                        | 6379   |
| cAdvisor              | cadvisor                     | 8090   |
| Prometheus            | prometheus                   | 9090   |
| Grafana               | grafana                      | 3000   |
| Zipkin                | zipkin                       | 9411   |

## Conclusión

Este proyecto demuestra una arquitectura de microservicios utilizando varias tecnologías, proporcionando una experiencia práctica con diferentes herramientas de construcción y entornos. Los scripts bash incluidos simplifican el proceso de construcción y ejecución de los contenedores, y la integración de herramientas de monitoreo como Prometheus, cAdvisor y Grafana asegura que la aplicación pueda ser monitoreada de manera efectiva en un entorno similar a la producción.

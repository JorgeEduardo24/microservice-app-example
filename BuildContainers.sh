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

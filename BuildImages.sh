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

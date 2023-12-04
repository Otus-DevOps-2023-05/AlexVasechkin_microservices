sudo docker network create app-network

sudo docker run -d \
  --name redis \
  --network app-network \
  --restart unless-stopped \
  aleksandervas/otus-devops-project-2023_redis:latest

sudo docker run -d \
  --name rabbitmq \
  --network app-network \
  --restart unless-stopped \
  -p 15672:15672 \
  -e RABBITMQ_DEFAULT_USER=admin \
  -e RABBITMQ_DEFAULT_PASS=admin \
  aleksandervas/otus-devops-project-2023_rabbitmq:latest

mkdir mkdir -p /home/ubuntu/project
echo "APP_ENV=prod" > /home/ubuntu/project/.env.local

sudo docker run -d \
  --name app \
  --network app-network \
  --restart unless-stopped \
  -p 80:80 \
  --mount type=bind,source=/home/ubuntu/project/.env.local,target=/app/.env.local \
  aleksandervas/otus-devops-project-2023_app:latest

sudo docker run -d \
  --name consumer \
  --network app-network \
  --restart unless-stopped \
  --mount type=bind,source=/home/ubuntu/project/.env.local,target=/app/.env.local \
  aleksandervas/otus-devops-project-2023_consumer:latest

sudo docker run -d \
  --name node-exporter \
  --network app-network \
  --restart unless-stopped \
  -v "/proc:/host/proc:ro,rslave" \
  -v "/sys:/host/sys:ro,rslave" \
  -v "/:/rootfs:ro,rslave" \
  aleksandervas/otus-devops-project-2023_node-exporter:latest \
  --path.procfs=/host/proc \
  --path.sysfs=/host/sys

sudo docker volume create prometheus_data

sudo docker run -d \
  --name prometheus \
  --network app-network \
  --restart unless-stopped \
  -v "prometheus_data:/prometheus" \
  -p 9090:9090 \
  aleksandervas/otus-devops-project-2023_prometheus:latest \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/prometheus \
  --storage.tsdb.retention=1d

sudo docker volume create grafana_data

sudo docker run -d \
  --name grafana \
  --network app-network \
  --restart unless-stopped \
  -v "grafana_data:/var/lib/grafana" \
  -p 3000:3000 \
  aleksandervas/otus-devops-project-2023_grafana:latest

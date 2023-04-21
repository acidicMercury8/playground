docker compose -f base-compose.yaml up -d
docker compose -f base-compose.yaml ps
docker compose -f base-compose.yaml down

docker compose -f base-compose.yaml \
    -f monitoring/docker-compose.yaml \
    -f event_service/docker-compose.yaml \
    -f location_service/docker-compose.yaml \
    -f task_manager/docker-compose.yaml \
    up -d

docker compose -f  base-compose.yaml \
    -f monitoring/docker-compose.yaml \
    -f event_service/capture-traffic.yaml \
    -f location_service/docker-compose.yaml \
    -f task_manager/capture-traffic.yaml \
    -f hoverfly/docker-compose.yaml \
    up -d

curl http://localhost:8888/api/v2/simulation

cd location_service
curl --location --request GET \
    'http://localhost:8888/api/v2/simulation?urlPattern=location-service:8080' \
    > location-simulation.json

cd monitoring
curl --location --request GET \
    'http://localhost:8888/api/v2/simulation?urlPattern=push-gateway:9091' \
    > push-gateway-simulation.json

docker compose -f base-compose.yaml \
    -f task_manager/docker-compose.yaml \
    -f location_service/mock-location-service.yaml \
    up -d

docker compose -f base-compose.yaml \
    -f event_service/docker-compose.yaml \
    -f monitoring/mock-push-gateway.yaml \
    up -d

docker compose -f base-compose.yaml \
    -f monitoring/docker-compose.yaml \
    -f event_service/capture-traffic.yaml \
    -f location_service/docker-compose.yaml \
    -f task_manager/capture-traffic.yaml \
    -f hoverfly/proxy.yaml \
    up -d

docker compose -f base-compose.yaml \
    -f monitoring/mock-push-gateway.yaml \
    -f event_service/docker-compose.yaml \
    -f location_service/docker-compose.yaml \
    -f task_manager/docker-compose.yaml \
    up -d

docker compose -f base-compose.yaml \
    -f location_service/mock-location-service.yaml \
    -f task_manager/docker-compose.yaml \
    up -d
docker compose -f base-compose.yaml \
    -f location_service/docker-compose.yaml \
    up -d
docker compose -f base-compose.yaml \
    -f monitoring/mock-push-gateway.yaml \
    -f event_service/docker-compose.yaml \
    up -d

docker compose -f base-compose.yaml \
    -f location_service/docker-compose.yaml \
    config

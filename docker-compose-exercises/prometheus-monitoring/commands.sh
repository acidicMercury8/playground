docker compose -f ./prometheusold.yaml up -d

docker compose build
docker compose up -d

# rate(task_event_processing_total[5m])

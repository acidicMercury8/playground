docker compose -f redis.yaml up -d
go mod init location_service
go get github.com/gin-gonic/gin
go get github.com/go-redis/redis/v8
go run main.go
curl --location --request POST 'localhost:8080/location/' \
    --header 'Content-Type: application/json' \
    --data-raw '{
        "id": "0c2e2081-075d-443a-ac20-40bf3b320a6f",
        "name": "Liverpoll Street Station",
        "description": "Station for Tube and National Rail",
        "longitude": -0.082966,
        "latitude": 51.517336
    }'
curl --location --request GET \
    'localhost:8080/location/0c2e2081-075d-443a-ac20-40bf3b320a6f'
curl --location --request GET \
    'localhost:8080/location/nearby?longitude=-0.0197&latitude=51.5055&distance=5&unit=km'

docker compose -f base-compose.yaml up -d

cd dynamodb-snippet
go mod init dynamodb-snippet
go get github.com/aws/aws-sdk-go/aws
go get github.com/aws/aws-sdk-go-v2/service/dynamodb

cd sqs-snippet
go mod init sqs-snippet
go get github.com/aws/aws-sdk-go/aws
go get github.com/aws/aws-sdk-go/service/sqs

cd s3-snippet
go mod init s3-snippet
go get github.com/aws/aws-sdk-go/aws
go get github.com/aws/aws-sdk-go/service/s3

cd newsletter-lambda
go mod init newsletter-lambda
go get github.com/aws/aws-lambda-go
go get github.com/aws/aws-sdk-go

docker compose -f docker-compose.yaml \
    -f newsletter-lambda/docker-compose.yaml \
    build
docker compose -f docker-compose.yaml \
    -f newsletter-lambda/docker-compose.yaml \
    up -d
curl -XPOST \
    "http://localhost:8080/2015-03-31/functions/function/invocations" \
    -d '{"email":"john@doe.com","topic":"Books"}' \
    "You have been subscribed to the Books newsletter"

cd s3store-lambda
go mod init s3store-lambda
go get github.com/aws/aws-lambda-go

cd sqs-to-lambda
go mod init sqs-to-lambda
go get github.com/aws/aws-lambda-go
go get github.com/aws/aws-sdk-go

docker compose -f docker-compose.yaml \
    -f newsletter-lambda/docker-compose.yaml \
    -f s3store-lambda/docker-compose.yaml \
    -f sqs-to-lambda/docker-compose.yaml \
    build
docker compose -f docker-compose.yaml \
    -f newsletter-lambda/docker-compose.yaml \
    -f s3store-lambda/docker-compose.yaml \
    -f sqs-to-lambda/docker-compose.yaml \
    up -d
curl -XPOST \
    "http://localhost:8080/2015-03-31/functions/function/invocations" \
    -d '{"email":"john@doe.com","topic":"Books"}' \
    "You have been subscribed to the Books newsletter"

curl "http://localhost:8080/hello?name=World"

docker pull postgres:12-alpine
docker run -d -p 5432:5432 --name db -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=password -e POSTGRES_DB=demo postgres:12-alpine

javap -private modern-stack-app/target/classes/ru/acidicmercury8/modernstack/models/Book

curl -X POST --location "http://localhost:8080/books"
    -H "Content-Type: application/json"
    -d "{
          "author" : "Joshua Bloch",
          "title" : "Effective Java",
          "price" : 54.99
        }"
curl -X POST --location "http://localhost:8080/books"
    -H "Content-Type: application/json"
    -d "{
          "author" : "Kathy Sierra",
          "title" : "Head First Java",
          "price" : 12.66
        }"
curl -X POST --location "http://localhost:8080/books"
    -H "Content-Type: application/json"
    -d "{
          "author" : "Benjamin J. Evans",
          "title" : "Java in a Nutshell: A Desktop Quick Reference",
          "price" : 28.14
        }"

docker exec -ti db sh
psql --username=admin --dbname=demo
SELECT * FROM books;

curl -X GET --location "http://localhost:8080/books"
    -H "Accept: application/json"
curl -X GET --location "http://localhost:8080/books/2"
    -H "Accept: application/json"
curl -X GET --location "http://localhost:8080/books?author=Bloch"
    -H "Accept: application/json"

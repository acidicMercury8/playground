import express, { urlencoded, json } from 'express';
import { join } from 'path';
import { readFileSync } from 'fs';
import { MongoClient } from 'mongodb';
let app = express();

app.use(urlencoded({ extended: true }));
app.use(json());

app.get('/', function (req, res) {
    res.sendFile(join(__dirname, "index.html"));
});

app.get('/profile-picture', function (req, res) {
    let img = readFileSync(join(__dirname, "img/profile-1.jpg"));
    res.writeHead(200, { 'Content-Type': 'image/jpg' });
    res.end(img, 'binary');
});

// Use when starting application locally with Node command
let mongoUrlLocal = "mongodb://admin:password@localhost:27017";
// Use when starting application as a separate Docker container
let mongoUrlDocker = "mongodb://admin:password@host.docker.internal:27017";
// Use when starting application as Docker container, part of Docker Compose
let mongoUrlDockerCompose = "mongodb://admin:password@mongodb";

let mongoUrlK8s = `mongodb://${process.env.USER_NAME}:${process.env.USER_PWD}@${process.env.DB_URL}`

// Pass these options to Mongo client connect request to avoid
// DeprecationWarning for current Server Discovery and Monitoring engine
let mongoClientOptions = { useNewUrlParser: true, useUnifiedTopology: true };
// "user-account" in demo with docker. "my-db" in demo with Docker Compose
let databaseName = "my-db";

app.post('/update-profile', function (req, res) {
    let userObj = req.body;

    MongoClient.connect(mongoUrlK8s, mongoClientOptions, function (err, client) {
        if (err) {
            throw err;
        }

        let db = client.db(databaseName);
        userObj['userid'] = 1;

        let myquery = { userid: 1 };
        let newvalues = { $set: userObj };
        db.collection("users").updateOne(myquery, newvalues, { upsert: true }, function(err, res) {
            if (err) {
                throw err;
            }

            client.close();
        });
    });

    // Send response
    res.send(userObj);
});

app.get('/get-profile', function (req, res) {
    let response = {};

    // Connect to the db
    MongoClient.connect(mongoUrlK8s, mongoClientOptions, function (err, client) {
        if (err) {
            throw err;
        }

        let db = client.db(databaseName);
        let myquery = { userid: 1 };
        db.collection("users").findOne(myquery, function (err, result) {
            if (err) {
                throw err;
            }

            response = result;
            client.close();

            // Send response
            res.send(response
                ? response
                : {});
        });
    });
});

app.listen(3000, function () {
    console.log("Application listening on port 3000!");
});

"use strict";

let connection = new signalR.HubConnectionBuilder().withUrl("https://localhost:5001/chatHub").build();

document.getElementById("sendButton").disabled = true;

document.getElementById("sendButton").addEventListener("click", function () {
    let user = document.getElementById("userInput").value;
    let message = document.getElementById("messageInput").value;
    connection.invoke("SendMessage", user, message)
        .catch(function (err) {
            return console.error(err.toString());
        });
});

connection.on("ReceiveMessage", function (user, message) {
    var li = document.createElement("li");
    document.getElementById("messagesList").appendChild(li);
    li.textContent = `${user}: ${message}`;
});

connection.start()
    .then(function () {
        document.getElementById("sendButton").disabled = false;
    })
    .catch(function (err) {
        return console.error(err.toString());
    });

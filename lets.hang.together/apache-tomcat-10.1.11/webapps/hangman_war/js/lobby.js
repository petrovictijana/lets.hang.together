var socket = null;
function connectToServer(name, surname, level, score) {
    if (!socket || !socket.connected) {
        socket = io("http://localhost:9090");
    }
}

function startGame(username, name, surname, level, score){
    var userData = new Object();
    userData.username = username;
    userData.name = name;
    userData.surname = surname;
    userData.level = level;
    userData.score = score;

    console.log(userData);

    console.log("Saljem podatke " + userData.name + userData.surname + userData.level + userData.score);
    socket.emit("userData", JSON.stringify(userData));
    console.log("Poslato");
}

// socket.on("gameStatus", (data) => {
//     console.log(data);
// });

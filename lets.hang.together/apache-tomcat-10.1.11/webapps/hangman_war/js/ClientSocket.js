var socket = null;

function connectToServer(){
    if (!socket || !socket.connected) {
        socket = io("http://localhost:9090");
    }
}

//TO SERVER
function startGame(username, name, surname, level, score){
    var userDetails = new Object();
    userDetails.username = username;
    userDetails.name = name;
    userDetails.surname = surname;
    userDetails.level = level;
    userDetails.score = score;

    socket.emit("startGame", JSON.stringify(userDetails));
    console.log("startGame: " + userDetails);
}

function letterGuess(letter){
    var letterGuess = new Object();
    letterGuess.letter = letter;

    socket.emit("letterGuess", JSON.stringify(letterGuess));
    console.log("letterGuess: " + letterGuess);
}

function wordGuess(word){
    var wordGuess = new Object();
    wordGuess.word = word;

    socket.emit("wordGuess", JSON.stringify(wordGuess));
    console.log("wordGuess: " + wordGuess);
}



//FROM SERVER
function getMissingWord(){
    socket.on("missingWord", (data) => {
        return data;
    });
}
function onTurn(){
    socket.on("onTurn", (data) => {
        return data;
    });
}

function availableAttempts(){
    socket.on("attemptsAvailable", (data) => {
        return data;
    });
}

function isLetterGuessed(){
    socket.on("isLetterGuessed", (data) => {
        return data;
    });
}

function isWordGuessed(){
    socket.on("isWordGuessed", (data) => {
        return data;
    });
}
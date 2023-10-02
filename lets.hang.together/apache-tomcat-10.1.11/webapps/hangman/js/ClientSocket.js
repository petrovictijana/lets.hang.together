var socket = null;
var amIPlayer1;
var username;
var onTurn = "PLAYER_1";
var wordGuessingList = [];
var availableAttempt = 10;

function connectToServer(username){
    this.username = username;
    socket = io("http://localhost:9090");

    startGame(username);

    receiveMessage();

    receiveLetterGuessStatus();

    receiveWordGuessStatus();

    isGameOver();
}

function startGame(username){
    var player = new Object();
    player.username = username;

    //Slanje zahteva za pocetak igre
    socket.emit("requestToPlay", JSON.stringify(player));

    var gameInitialized = false;

    socket.on("initializeGame", (data) => {
        if(gameInitialized)
            return;

        gameInitialized = true;

        receivedData = JSON.parse(data);

        availableAttempt = receivedData.attemptsAvailable;

        document.getElementById("myModal-waiting").style.display = "none";

        document.getElementById("myModal-playing").style.display = "block";
        document.getElementById("modal-text-playing").innerText = "The game is starting soon...";

        document.getElementById("player1").innerText = receivedData.player1Username;
        document.getElementById("player2").innerText = receivedData.player2Username;
        document.getElementById("attempts").innerText = receivedData.attemptsAvailable;
        document.getElementById("points").innerText = receivedData.points;

        if(receivedData.player1Username == username)
            amIPlayer1 = true;
        else
            amIPlayer1 = false;

        setTimeout(() => {
                document.getElementById("myModal-playing").style.display = "none";
                if(!amIPlayer1 && onTurn == "PLAYER_1"){
                    document.getElementById("myModal-playing").style.display = "block";
                    document.getElementById("modal-text-playing").innerText = "The spotlight's on the opponent now";
                }
            }, 2000
        );

        const wordContainer = document.querySelector(".word-container");
        const missingWordLength = receivedData.missingWordLettersNumber;

        for (let i = 0; i < missingWordLength; i++) {
            const letterDiv = document.createElement("div");
            letterDiv.classList.add("letter-guessed");
            letterDiv.setAttribute("id", "letter-guessed" + i);

            wordContainer.appendChild(letterDiv);
        }
    });


}

function getCurrentTime() {
    const now = new Date();
    const hours = now.getHours();
    const minutes = now.getMinutes();
    return `${hours}:${minutes}`;
}


function sendMessage(){
    var message = document.getElementById("message").value;

    if(message.trim() !== ""){
        var privateMessage = new Object();
        privateMessage.to = "";
        privateMessage.from = username;
        privateMessage.message = message;

        socket.emit("sendMessage", JSON.stringify(privateMessage));

        const chat = document.getElementById("direct-chat-messages");

        var imageUrl = "utilities/images/icons/";
        if(amIPlayer1){
            imageUrl += "player1.png";
        }
        else{
            imageUrl += "player2.png";
        }

        var messageDivBody = `
    <div class="direct-chat-msg right">
        <div class="direct-chat-info clearfix">
            <span class="direct-chat-name pull-right" id="from-received">${username}</span>
            <span class="direct-chat-timestamp pull-left" id="time-received">${getCurrentTime()}</span>
        </div>

        <img class="direct-chat-img" src="${imageUrl}" alt="message user image">

        <div class="direct-chat-text" id="message-received">
            ${message}
        </div>
    </div>`;

        chat.innerHTML += messageDivBody;

        //Ocistiti input polje
        document.getElementById("message").value = "";
        //Prikaz poslednje poruke
        chat.scrollTop = chat.scrollHeight;
    }
}

function receiveMessage(){
    socket.on("messageReceived", (data) => {
        message = JSON.parse(data);

        var from = message.from;
        var message = message.message;

        const chat = document.getElementById("direct-chat-messages");

        var imageUrl = "utilities/images/icons/";
        if(amIPlayer1){
            imageUrl += "player2.png";
        }
        else{
            imageUrl += "player1.png";
        }
        const messageDivBody = `
        <div class="direct-chat-info clearfix">  
              <span class="direct-chat-name pull-left" id="name">${from}</span>
              <span class="direct-chat-timestamp pull-right">${getCurrentTime()}</span>
        </div>
        
        <img class="direct-chat-img" src="${imageUrl}" alt="message user image">
        
        <div class="direct-chat-text">
            ${message}
        </div>
        `;

        chat.innerHTML += messageDivBody;

        chat.scrollTop = chat.scrollHeight;
    });
}

function letterGuess(letter){
    var letterGuess = new Object();
    letterGuess.letter = letter;

    socket.emit("letterGuess", JSON.stringify(letterGuess));
}

function receiveLetterGuessStatus(){
    socket.on("letterGuessing", (data) => {
        var receivedData = JSON.parse(data);

        var onTurn = receivedData.onTurn;
        var availableAttempts = receivedData.availableAttempts;
        var letter = receivedData.letter;
        var isLetterGuessed = receivedData.isLetterGuessed;
        var guessedLetterPositions = receivedData.guessedLetterPositions;
        var points = receivedData.points;

        availableAttempt = receivedData.attemptsAvailable;

        document.getElementById("hangman").src = "utilities/images/hangmans/" + availableAttempts + ".png";

        document.getElementById("attempts").innerText = availableAttempts;
        document.getElementById("points").innerText = points;

        console.log(receivedData);

        document.getElementById(letter).disabled = true;

        if(isLetterGuessed){
            for (let i = 0; i < guessedLetterPositions.length; i++) {
                let divName = "letter-guessed" + guessedLetterPositions[i];

                let pElement = document.createElement("p");
                pElement.className = "letter";
                pElement.innerText = letter;

                document.getElementById(divName).appendChild(pElement);
            }
        }
        else{
            if(amIPlayer1 && onTurn == "PLAYER_1" || !amIPlayer1 && onTurn == "PLAYER_2"){
                //Ukoliko sam ja na potezu
                document.getElementById("myModal-playing").style.display = "none";
            }
            else{
                document.getElementById("myModal-playing").style.display = "block";
            }
        }

        var myModal = document.getElementById("myModal-waiting");
    });
}

function wordGuess(){
    var word = document.getElementById("guess").value;

    var wordGuess = new Object();
    wordGuess.word = word;

    socket.emit("wordGuess", JSON.stringify(wordGuess));
}

function receiveWordGuessStatus(){
    socket.on("wordGuessing", (data) => {
        var receivedData = JSON.parse(data);
        var word = receivedData.word;
        var points = receivedData.points;
        var availableAttempts = receivedData.availableAttempts;
        var onTurn = receivedData.onTurn;

        document.getElementById("attempts").innerText = availableAttempts;
        document.getElementById("points").innerText = points;

        availableAttempt = receivedData.attemptsAvailable;

        wordGuessingList.push(word);

        var wordSpan = document.createElement('span');
        wordSpan.className = 'word';
        wordSpan.textContent = word;
        document.getElementById("words-try").appendChild(wordSpan);

        if(amIPlayer1 && onTurn == "PLAYER_1" || !amIPlayer1 && onTurn == "PLAYER_2"){
            //Ukoliko sam ja na potezu
            document.getElementById("myModal-playing").style.display = "none";

        }
        else{
            document.getElementById("myModal-playing").style.display = "block";
        }
    });
}


function isGameOver(){
    socket.on("gameOver", (data) => {

        var receivedData = JSON.parse(data);
        var winner = receivedData.winner;
        var points = receivedData.points;
        var missingWord = receivedData.missingWord;

        document.getElementById("myModal-playing").style.display = "none";

        //Prikaz modala za pobednika
        document.getElementById("myModal-winner").style.display = "block";

        document.getElementById("winner").innerText = winner;
        if(winner == "It's a draw!"){
            document.getElementById("winner-points").innerText = "X";
            document.getElementById("winner-points").style.color = "red";
        }
        else{
            document.getElementById("winner-points").innerText = points;
        }
        document.getElementById("winner-missing-word").innerText = missingWord;

    });

}


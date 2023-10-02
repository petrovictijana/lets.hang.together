<%@ page import="models.UserModel" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    UserModel user = new UserModel();
    if(session.getAttribute("user") != null){
        user = (UserModel) session.getAttribute("user");
        System.out.println(user.getUsername());
    }
%>

<html>
<head>
    <title>Playroom</title>
    <link rel="stylesheet" href="styles/common.css">
    <link rel="stylesheet" href="styles/playroom.css">
    <link rel="stylesheet" href="styles/chat.css">
    <script src="https://cdn.socket.io/4.0.1/socket.io.min.js"></script>
    <script src="js/ClientSocket.js"></script>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
</head>
<body onload="connectToServer('<%= user.getUsername()%>')">
<div class="overlay-container">

    <div id="myModal-winner" class="modal" style="display: none;">
        <%--        Modal za winner-a        --%>
        <!-- Modal content -->
        <div class="modal-content">
            <img src="utilities/images/icons/winner.png" alt="winner-img" />
            <p style="font-size: 30px; letter-spacing: 2px; color: darkred; margin-bottom: 20px" id="winner">filip.filipovic</p>
            <span>Points: <span style="margin-bottom: 20px; font-size: 30px; color: darkcyan" id="winner-points">8</span></span>
            <br>
            <span>Missing word:<span style="margin-bottom: 20px; font-size: 30px; color: #ff8800; margin-left: 10px; letter-spacing: 2px" id="winner-missing-word">letter</span></span>
            <br>
            <button class="accept" onclick="window.location.href='/lobby'">Back to lobby!</button>
        </div>
    </div>

    <div id="myModal-waiting" class="modal" style="display: block;">
        <%--        Modal za winner-a        --%>
        <!-- Modal content -->
        <div class="modal-content" style="display: flex !important; flex-direction: column !important; align-items: center !important; justify-content: center !important">
            <img src="utilities/images/icons/communication.png" style="margin-bottom: 30px; width: 100px !important; height: 100px !important;">
            <span id="modal-text" style="font-size: 25px; color: darkred">Waiting for another player...</span>
        </div>
    </div>

    <div id="myModal-playing" class="modal" style="display: none;">
        <%--        Modal za winner-a        --%>
        <!-- Modal content -->
        <div class="modal-content" style="display: flex !important; flex-direction: column !important; align-items: center !important; justify-content: center !important">
            <img src="utilities/images/icons/opponent.png" style="margin-bottom: 30px; width: 100px !important; height: 100px !important;">
            <span id="modal-text-playing" style="font-size: 25px; color: darkred"></span>
        </div>
    </div>


    <div class="header-container-playroom">
        <div class="header-container-playroom-first" style="margin-top: 50px !important;">
            <div class="player1-container">
                <img src="utilities/images/icons/player1.png">
                <span id="player1"></span>
            </div>
    
            <div class="attempts-available" style="margin-left: 10px; margin-right: 10px;">
                <!-- <span id="attempts"></span> -->
                <div>
                    <p>Remaining attempts</p>
                </div>
                <div class="numberOfAttempts">
                    <p style="font-size: 30px; color: #7e1522;" id="attempts"></p>
                </div>
            </div>
    
            <div class="player2-container">
                <img src="utilities/images/icons/player2.png">
                <span id="player2"></span>
            </div>
        </div>
        <div class="header-container-playroom-secound">
            <p>points: <span id="points" style="color: greenyellow; font-size: 30px; margin-left: 10px"></span></p>
        </div>
    </div>

    <div class="main-container slide-in-left">
        <div class="game-container">
            <div class="hangman-container">
                <img src="utilities/images/hangmans/10.png" id="hangman" style="width: 300px; height: 500px;">
            </div>
            <div class="guess-container">
                <div class="letters-container">
                    <div class="letter-row">
                        <button class="letter-btn scale" value="A" id="A" onclick="letterGuess('A')">A</button>
                        <button class="letter-btn scale" value="B" id="B" onclick="letterGuess('B')">B</button>
                        <button class="letter-btn scale" value="C" id="C" onclick="letterGuess('C')">C</button>
                        <button class="letter-btn scale" value="D" id="D" onclick="letterGuess('D')">D</button>
                        <button class="letter-btn scale" value="E" id="E" onclick="letterGuess('E')">E</button>
                        <button class="letter-btn scale" value="F" id="F" onclick="letterGuess('F')">F</button>
                        <button class="letter-btn scale" value="G" id="G" onclick="letterGuess('G')">G</button>
                    </div>
                    <div class="letter-row">
                        <button class="letter-btn scale" value="H" id="H" onclick="letterGuess('H')">H</button>
                        <button class="letter-btn scale" value="I" id="I" onclick="letterGuess('I')">I</button>
                        <button class="letter-btn scale" value="J" id="J" onclick="letterGuess('J')">J</button>
                        <button class="letter-btn scale" value="K" id="K" onclick="letterGuess('K')">K</button>
                        <button class="letter-btn scale" value="L" id="L" onclick="letterGuess('L')">L</button>
                        <button class="letter-btn scale" value="M" id="M" onclick="letterGuess('M')">M</button>
                        <button class="letter-btn scale" value="N" id="N" onclick="letterGuess('N')">N</button>
                    </div>
                    <div class="letter-row">
                        <button class="letter-btn scale" value="O" id="O" onclick="letterGuess('O')">O</button>
                        <button class="letter-btn scale" value="P" id="P" onclick="letterGuess('P')">P</button>
                        <button class="letter-btn scale" value="Q" id="Q" onclick="letterGuess('Q')">Q</button>
                        <button class="letter-btn scale" value="R" id="R" onclick="letterGuess('R')">R</button>
                        <button class="letter-btn scale" value="S" id="S" onclick="letterGuess('S')">S</button>
                        <button class="letter-btn scale" value="T" id="T" onclick="letterGuess('T')">T</button>
                        <button class="letter-btn scale" value="U" id="U" onclick="letterGuess('U')">U</button>
                    </div>
                    <div class="letter-row">
                        <button class="letter-btn scale" value="V" id="V" onclick="letterGuess('V')">V</button>
                        <button class="letter-btn scale" value="W" id="W" onclick="letterGuess('W')">W</button>
                        <button class="letter-btn scale" value="X" id="X" onclick="letterGuess('X')">X</button>
                        <button class="letter-btn scale" value="Y" id="Y" onclick="letterGuess('Y')">Y</button>
                        <button class="letter-btn scale" value="Z" id="Z" onclick="letterGuess('Z')">Z</button>
                    </div>
                </div>
                <div class="word-container">
                    <!-- OVDE TREBA DA IDU CRTICE -->
                </div>
                <div class="word-guess-container">
                    <form class="word-guess-form">
                        <input type="text" class="guess" id="guess" placeholder="Enter your guess" onkeyup="checkButton()">
                        <input type="button" class="guess-btn scale" id="word-guess" value="Guess" onclick="wordGuess()" disabled>
                    </form>
                </div>

                <div class="words-try" id="words-try">

                </div>
            </div>
        </div>
        <div class="chat-container slide-in-right">
            <div>
                <img class="holder" src="utilities/images/holder-v3.png">
            </div>
            <div class="page-content page-container" id="page-content" style="min-width: 620px">
                <div class="padding">
                    <div class="row container d-flex justify-content-center">
                        <div class="col-md-4">

                            <div class="box box-warning direct-chat direct-chat-warning">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Chat Messages</h3>

                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                        </button>
                                        <button type="button" class="btn btn-box-tool" data-toggle="tooltip" title="" data-widget="chat-pane-toggle" data-original-title="Contacts">
                                            <i class="fa fa-comments"></i></button>
                                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i>
                                        </button>
                                    </div>
                                </div>

                                <div class="box-body" id="chat-box">

                                    <div class="direct-chat-messages" id="direct-chat-messages">

                                    </div>

                                </div>

                                <div class="box-footer">
                                    <form action="#" method="post">
                                        <div class="input-group">
                                            <input id="message" type="text" name="message" placeholder="Type Message..." class="form-control">
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-warning btn-flat" onclick="sendMessage()"><span>Send</span>></button>
                                              </span>
                                        </div>
                                    </form>
                                </div>

                            </div>

                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>


</div>


</body>

<script>
    // Funkcija koja će se pozvati kada korisnik pritisne Enter
    function handleKeyPress(event) {
        if (event.keyCode === 13) { // Provera da li je pritisnut Enter taster (keyCode 13)
            sendMessage();
            event.preventDefault();
        }
    }

    document.getElementById("message").addEventListener("keypress", handleKeyPress);

    function checkButton(){
        if(document.getElementById("guess").value.trim() != ""){
            document.getElementById("word-guess").disabled = false;
        }
    }

</script>


</html>

<%@ page import="models.UserModel" %>
<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 8/12/2023
  Time: 1:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserModel user = new UserModel();
    if(session.getAttribute("user") != null){
        user = (UserModel) session.getAttribute("user");
    }
%>

<html>
<head>
    <title>Playroom</title>
    <link rel="stylesheet" href="styles/common.css">
    <link rel="stylesheet" href="styles/playroom.css">
    <link rel="stylesheet" href="styles/chat.css">
    <script src="https://cdn.socket.io/4.0.1/socket.io.min.js"></script>
</head>
<body>
<div class="overlay-container">
<%--    <div class="header-container">--%>
<%--        <div class="label">--%>
<%--            <span>Let's HANG together</span>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <div class="blue-container">--%>
<%--        <div class="profile-container">--%>
<%--            <button class="btn-settings"><img src="utilities/images/icons/profile_icon.png">my Profile</button>--%>
<%--        </div>--%>
<%--        <div class="name-container">--%>
<%--            <span style="color: white; font-size: 24px; letter-spacing: 3px">Tijana Petrovic</span>--%>
<%--        </div>--%>
<%--        <div class="logount-container">--%>
<%--            <button class="btn-settings"><img src="utilities/images/icons/leave_icon.png">Logout</button>--%>
<%--        </div>--%>
<%--    </div>--%>

    <div class="header-container-playroom">
        <div class="player1-container">
            <img src="utilities/images/icons/profile_icon.png">
            <span>Tijana Petrovic</span>
        </div>

        <div class="attempts-available">
            7
        </div>

        <div class="player2-container">
            <img src="utilities/images/icons/profile_icon.png">
            <span>Tijana Petrovic</span>
        </div>
    </div>

    <div class="main-container">
        <div class="game-container">
            <div class="hangman-container">
                <img src="utilities/images/hangmans/0.png">
            </div>
            <div class="guess-container">
                <div class="letters-container">
                    <div class="letter-row">
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                    </div>
                    <div class="letter-row">
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                    </div>
                    <div class="letter-row">
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                    </div>
                    <div class="letter-row">
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                        <button class="letter-btn">A</button>
                    </div>
                </div>
                <div class="word-container">
                    <div class="letter-guessed"></div>
                    <div class="letter-guessed"></div>
                    <div class="letter-guessed"></div>
                    <div class="letter-guessed"></div>
                    <div class="letter-guessed"></div>
                </div>
                <div class="word-guess-container">
                    <form>
                        <input type="text" class="guess" placeholder="Enter your guess">
                        <input type="button" class="guess-btn" value="Guess">
                    </form>
                </div>
            </div>
        </div>
        <div class="chat-container">
            <div class="page-content page-container" id="page-content">
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

                                <div class="box-body">

                                    <div class="direct-chat-messages">

                                        <div class="direct-chat-msg">
                                            <div class="direct-chat-info clearfix">
                                                <span class="direct-chat-name pull-left">Timona Siera</span>
                                                <span class="direct-chat-timestamp pull-right">23 Jan 2:00 pm</span>
                                            </div>

                                            <img class="direct-chat-img" src="https://img.icons8.com/color/36/000000/administrator-male.png" alt="message user image">

                                            <div class="direct-chat-text">
                                                For what reason would it be advisable for me to think about business content?
                                            </div>

                                        </div>

                                        <div class="direct-chat-msg right">
                                            <div class="direct-chat-info clearfix">
                                                <span class="direct-chat-name pull-right">Sarah Bullock</span>
                                                <span class="direct-chat-timestamp pull-left">23 Jan 2:05 pm</span>
                                            </div>

                                            <img class="direct-chat-img" src="https://img.icons8.com/office/36/000000/person-female.png" alt="message user image">

                                            <div class="direct-chat-text">
                                                Thank you for your believe in our supports
                                            </div>

                                        </div>



                                        <div class="direct-chat-msg">
                                            <div class="direct-chat-info clearfix">
                                                <span class="direct-chat-name pull-left">Timona Siera</span>
                                                <span class="direct-chat-timestamp pull-right">23 Jan 5:37 pm</span>
                                            </div>

                                            <img class="direct-chat-img" src="https://img.icons8.com/color/36/000000/administrator-male.png" alt="message user image">

                                            <div class="direct-chat-text">
                                                For what reason would it be advisable for me to think about business content?
                                            </div>

                                        </div>

                                        <div class="direct-chat-msg right">
                                            <div class="direct-chat-info clearfix">
                                                <span class="direct-chat-name pull-right">Sarah Bullock</span>
                                                <span class="direct-chat-timestamp pull-left">23 Jan 6:10 pm</span>
                                            </div>

                                            <img class="direct-chat-img" src="https://img.icons8.com/office/36/000000/person-female.png" alt="message user image">

                                            <div class="direct-chat-text">
                                                I would love to.
                                            </div>

                                        </div>


                                    </div>

                                </div>

                                <div class="box-footer">
                                    <form action="#" method="post">
                                        <div class="input-group">
                                            <input type="text" name="message" placeholder="Type Message..." class="form-control">
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-warning btn-flat"><span>Send</span>></button>
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
    const name = '<%= user.getName() %>';
    const surname = '<%= user.getSurname() %>';
    const level = '<%= user.getLevel() %>';
    const score = '<%= user.getScore() %>';

    // document.addEventListener('DOMContentLoaded', function() {
    //     connectToServer(name, surname, level, score);
    // });
    //
    // function connectToServer(name, surname, level, score) {
    //     const socket = io("http://localhost:9090",  {
    //         query: {
    //             name: name,
    //             surname: surname,
    //             level: level,
    //             score: score
    //         }
    //     });
    //
    //     console.log("Konektovani na server");
    //
    //     socket.on("connect", () => {
    //         console.log("Connected to server");
    //     });
    //
    //     socket.on("GAMESTATUS", function(data){
    //         console.log("Status: " + data);
    //     });
    // }

</script>

</html>

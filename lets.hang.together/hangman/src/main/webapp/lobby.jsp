<%@ page import="models.UserModel" %>
<%@ page import="java.util.List" %>
<%@ page import="models.UserModelDTO" %>
<%@ page import="apis.UserModelAPIs" %>
<%@ page import="data.DbConnectionJPA" %><%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 7/30/2023
  Time: 6:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    UserModelAPIs apIs = new DbConnectionJPA();

    UserModel user = new UserModel();
    if(session.getAttribute("user") != null){
        user = (UserModel) session.getAttribute("user");
        user.setScore(apIs.getScoreById(user.getId()));

        System.out.println("setovano user" + user.getId() + user.getScore());
    }

    List<UserModelDTO> top3Users = apIs.getTop3Players();

%>
<html>
<head>
    <title>Lobby</title>
    <link rel="stylesheet" href="styles/common.css">
    <link rel="stylesheet" href="styles/lobby.css">
    <script src="https://cdn.socket.io/4.5.4/socket.io.min.js"></script>
</head>
<body onload="resetScore()">
<div class="overlay-container">
    <div class="header-container" style="margin-top: 50px !important;">
        <div class="label">
            <span>Let's HANG together</span>
        </div>
    </div>

    <div class="main-container">



        <div class="left-container">
            <img src="utilities/images/icons/user%20(3).png" style="width: 200px; height: 200px">

                <div class="data">
                    <span class="label-card"><%= user.getName() + " " + user.getSurname()%></span>
                </div>

                <div class="data">
                    <span class="label-card" style="color: darkcyan !important;"><%= user.getUsername() %></span>
                </div>

                <div class="data">
                    <span class="label-card" style="color: darkgreen !important;" id="score">SCORE: <%= user.getScore() %></span>
                </div>

                <button class="accept" onclick="window.location.href='/sign_in'">Logout</button>
        </div>



        <div class="middle-container">
                <button class="button-52" role="button" onclick="window.location.href='/playroom'">PLAY</button>
        </div>



        <div class="right-container">
            <div class="scorer">
                <img src="utilities/images/icons/first.png">
                <div class="scorer-data">
                    <span class="name"><%= top3Users.get(0).getName() + " " + top3Users.get(0).getSurname()%></span>
                    <span class="score">Points: <%= top3Users.get(0).getScore()%></span>
                </div>
            </div>

            <div class="scorer">
                <img src="utilities/images/icons/second.png">
                <div class="scorer-data">
                    <span class="name"><%= top3Users.get(1).getName() + " " + top3Users.get(1).getSurname()%></span>
                    <span  class="score">Points: <%= top3Users.get(1).getScore()%></span>
                </div>
            </div>

            <div class="scorer">
                <img src="utilities/images/icons/second.png">
                <div class="scorer-data">
                    <span class="name"><%= top3Users.get(2).getName() + " " + top3Users.get(2).getSurname()%></span>
                    <span  class="score">Points: <%= top3Users.get(2).getScore()%></span>
                </div>
            </div>
        </div>
    </div>

</div>
</div>

</body>

<script>
    function changeClass(button) {
        if (button.classList.contains('active-btn')) {
            return; // Do nothing if the button is active
        }

        var btn1 = document.getElementById('btn1');
        var btn2 = document.getElementById('btn2');

        btn1.classList.toggle('active-btn');
        btn1.classList.toggle('other-btn');
        btn2.classList.toggle('active-btn');
        btn2.classList.toggle('other-btn');
    }

    function resetScore(){
        document.getElementById("score").innerText = <%= user.getScore()%>;
    }
</script>
</html>

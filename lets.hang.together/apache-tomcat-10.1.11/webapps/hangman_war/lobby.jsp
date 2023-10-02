<%@ page import="models.UserModel" %>
<%@ page import="java.util.List" %>
<%@ page import="apis.APIs" %>
<%@ page import="data.DbConnection" %>
<%@ page import="models.UserModelDTO" %><%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 7/30/2023
  Time: 6:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    APIs apIs = DbConnection.get_dbConnection();

    UserModel user = new UserModel();
    if(session.getAttribute("user") != null){
        user = (UserModel) session.getAttribute("user");
    }

    List<UserModelDTO> top5Users = apIs.getTop5Players();
%>
<html>
<head>
    <title>Lobby</title>
    <link rel="stylesheet" href="styles/common.css">
    <link rel="stylesheet" href="styles/lobby.css">
    <script src="https://cdn.socket.io/4.5.4/socket.io.min.js"></script>
    <script src="js/lobby.js"></script>
</head>
<body onload="connectToServer('<%= user.getUsername()%>','<%= user.getName()%>', '<%= user.getSurname()%>', '<%= user.getLevel()%>', '<%= user.getScore()%>')">
<div class="overlay-container">
    <div class="header-container">
        <div class="label">
            <span>Let's HANG together</span>
        </div>
    </div>

    <div class="blue-container">
        <div class="profile-container">
            <button class="btn-settings" onclick="window.location.href='profile.jsp'"><img src="utilities/images/icons/profile_icon.png">my Profile</button>
        </div>
        <div class="name-container">
            <span style="color: white; font-size: 24px; letter-spacing: 3px"><%= user.getName() + " "%><%= user.getSurname()%></span>
        </div>
        <div class="logount-container">
            <button class="btn-settings"><img src="utilities/images/icons/leave_icon.png">Logout</button>
        </div>
    </div>

    <div class="main-container">
        <div class="left-container">
            <div class="current-level">
                <span class="title-current">Current level</span>
                <span class="level-current"><%= user.getLevel()%></span>
                <span class="score-current">Score: <%= user.getScore()%></span>
            </div>
            <div class="next-level">
                <span class="title-next">Next level</span>
                <span class="level-next"><%= user.getLevel() + 1%></span>
                <span class="score-next">Till next: <%= user.getLevel() * 10 - user.getScore() + 1%> pts</span>
            </div>
        </div>
        <div class="middle-container">
            <button class="play-btn" onclick="startGame('<%= user.getName()%>', '<%= user.getSurname()%>', '<%= user.getLevel()%>', '<%= user.getScore()%>')">PLAY</button>
        </div>
        <div class="right-container">
            <span style="color: white; font-size: 35px">TOP <%= top5Users.size()%></span>
            <%
                for (UserModelDTO userModelDTO : top5Users) {
                    System.out.println(userModelDTO.toString());
            %>
            <div class="row">
                <span class="name"><%= userModelDTO.getName() + " " + userModelDTO.getSurname()%></span>
                <span class="name"><%= userModelDTO.getScore()%></span>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <div class="active-players-container">
        <div class="btns-container">
            <button class="active-btn" id="btn1" onclick="changeClass(this)">Active</button>
            <button class="other-btn" id="btn2" onclick="changeClass(this)"><span>Ready to play</span></button>
        </div>
        <div class="active-icons-container">
            <div class="card">
                <span>Level 5</span>
                <span>Marko</span>
                <span>Score: 45</span>
            </div>
            <div class="card">
                <span>Level 5</span>
                <span>Marko</span>
                <span>Score: 45</span>
            </div>
            <div class="card">
                <span>Level 5</span>
                <span>Marko</span>
                <span>Score: 45</span>
            </div>
            <div class="card">
                <span>Level 5</span>
                <span>Marko</span>
                <span>Score: 45</span>
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
</script>
</html>

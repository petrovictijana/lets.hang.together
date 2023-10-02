<%@ page import="apis.APIs" %>
<%@ page import="data.DbConnection" %>
<%@ page import="models.UserModel" %><%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 8/12/2023
  Time: 1:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    APIs apIs = DbConnection.get_dbConnection();

    UserModel user = new UserModel();
    if(session.getAttribute("user") != null){
        user = (UserModel) session.getAttribute("user");
    }
%>
<html>
<head>
    <title>My profile</title>
    <link rel="stylesheet" href="styles/common.css">
    <link rel="stylesheet" href="styles/profile.css">
</head>
<body>
<div class="overlay-container">
  <div class="header-container">
    <div class="label">
      <span>Let's HANG together</span>
    </div>
  </div>

    <div class="profile-settings-div">
        <div class="title-container">
            <div class="icon">
                <a href="lobby.jsp"> <img src="utilities/images/icons/leave_icon.png"></a>
            </div>
            <div class="title">
                <h3 class="title-settings">Profile settings</h3>
            </div>
        </div>
        <form class="form-settings">
            <input type="text" name="name" class="input-field" placeholder="<%= user.getName()%>" style="width: 50%">
            <input type="text" name="surname" class="input-field" placeholder="<%= user.getSurname()%>" style="width: 50%">
            <input type="password" name="password" class="input-field" placeholder="Enter password" onkeyup="passwordMatchConfirmation()" style="width: 50%">
            <input type="password" id="confirm_password" name="confirm-password" class="input-field" onkeyup="passwordMatchConfirmation()" placeholder="Confirm password" style="width: 50%">

            <button type="submit" class="submit-button" style="width: 50%">Save changes</button>
        </form>
    </div>



</div>

</body>

<script>
    function passwordMatchConfirmation(){
        var password = document.getElementsByName("password")[0].value;
        var confirm_password = document.getElementsByName("confirm-password")[0].value;
        var confirmPasswordField = document.getElementById("confirm_password");

        if(password.trim() !== "" && password.trim() !== confirm_password.trim()){
            confirmPasswordField.style.border = "2px solid red";
        } else {
            confirmPasswordField.style.border = ""; // Reset border
        }
    }
</script>

</html>

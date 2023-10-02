
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    session.removeAttribute("addNewUser");
%>
<html>
<head>
    <title>Add new user</title>
    <link rel="stylesheet" href="styles/common.css">
    <link rel="stylesheet" href="styles/add-new.css">
  <link rel="stylesheet" href="styles/admin-homepage.css">
</head>
<body>
<div class="overlay-container">
  <h1 style="color: white; text-align: center ">ADD NEW USER</h1>
  <div id="myModal" class="modal" style="display: block;">

    <!-- Modal content -->
    <div class="modal-content" style=" width: 50% !important; border-color: #1a1a1a;">
      <span style="font-family: Bunge-Regular; font-size: 30px;">Create new user</span>
      <form action="admin-homepage.jsp" method="POST">
        <div class="name-surname-container">
          <input type="text" onkeyup="formSubmit()" name="name" placeholder="Enter name" class="input-field" style="width: 47%; margin-right: 5% ">

          <input type="text" onkeyup="formSubmit()" name="surname" placeholder="Enter surname" class="input-field" style="width: 47%">
        </div>

        <div class="name-surname-container">
          <input type="text" onkeyup="formSubmit()" name="username" placeholder="Enter username" class="input-field" style="width: 47%; margin-right: 5% ">

          <select class="input-field" name="role_id" style="width: 47%">
            <option>Select role</option>
            <option value="1">Admin</option>
            <option value="2">User</option>
          </select>
        </div>

        <div class="name-surname-container">
          <input type="password" onkeyup="formSubmit()" name="password" placeholder="Enter password" class="input-field" style="width: 47%; margin-right: 5% ">
        </div>

        <%
          session.setAttribute("addNewUser", true);
        %>

        <div class="name-surname-container" style="margin-top: 30px !important;">
          <button type="submit" class="submit-button" style="width: 30%; margin-right: 5% ">Create</button>
        </div>

        <div id="username-taken-modal" class="modal" style="display: none">
          <!-- Modal content -->
          <div class="modal-content">
            <span class="close">&times;</span>
            <p>Username is already taken</p>
          </div>
        </div>

        <div id="user-created-modal" class="modal" style="display: none">
          <!-- Modal content -->
          <div class="modal-content">
            <span class="close">&times;</span>
            <p>User is created successfully</p>
          </div>
        </div>

      </form>
    </div>
</div>
</body>
</html>

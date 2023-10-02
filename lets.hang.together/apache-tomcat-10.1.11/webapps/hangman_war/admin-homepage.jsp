<%@ page import="apis.APIs" %>
<%@ page import="data.DbConnection" %>
<%@ page import="models.UserModel" %>
<%@ page import="java.util.List" %>
<%@ page import="utilities.enums.SortCriteria" %><%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 8/12/2023
  Time: 1:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    APIs apIs = DbConnection.get_dbConnection();

    UserModel user = new UserModel();
    if(session.getAttribute("user") != null){
        user = (UserModel) session.getAttribute("user");
    }

    //2 is for all users (blocked and unblocked)
    List<UserModel> users = apIs.getAllUsersSortedByCriteria(0, 2, SortCriteria.NAME, true);
%>
<html>
<head>
    <title>Homepage</title>
    <link rel="stylesheet" href="styles/common.css">
    <link rel="stylesheet" href="styles/admin-homepage.css">
</head>
<body>
<div class="overlay-container">
    <div class="header-container">
        <div class="label">
            <span>Let's HANG together</span>
        </div>
    </div>

    <div class="blue-container">

        <div class="name-container">
            <span style="color: white; font-size: 25px; letter-spacing: 3px; font-family: Bunge-Regular"><%= user.getName() + " "%><%= user.getSurname()%></span>
        </div>
        <div class="logount-container">
            <button class="btn-settings"><img src="utilities/images/icons/leave_icon.png">Logout</button>
        </div>
    </div>

    <div class="all-users-container">
        <div class="btn-container">
            <div class="filters-container">
                <div class="filter-box">
                    <span class="label-filter" style="margin-bottom: 7px">Filter by Role</span>
                    <select class="input-field" id="roleFilter">
                        <option value="0">All</option>
                        <option value="1">Admins</option>
                        <option value="2">Users</option>
                    </select>
                </div>

                <div class="filter-box">
                    <span class="label-filter" style="margin-bottom: 7px">Filter by Blocked Status</span>
                    <select class="input-field" id="blockedFilter">
                        <option value="0">All</option>
                        <option value="1">Blocked</option>
                        <option value="2">Unblocked</option>
                    </select>
                </div>

                <div class="separator">

                </div>

                <div class="filter-box">
                    <span class="label-filter" style="margin-bottom: 7px">Sort by</span>
                    <select class="input-field" id="sortBy">
                        <option>Name</option>
                        <option>Surname</option>
                        <option>Level</option>
                        <option>Score</option>
                    </select>
                </div>

                <div class="filter-box">
                    <span class="label-filter" style="margin-bottom: 7px">Sort Order</span>
                    <select class="input-field" id="sortOrder">
                        <option>Ascending</option>
                        <option>Descending</option>
                    </select>
                </div>
            </div>

            <div class="btn" style="width: 20%; display: flex; align-items: end; justify-content: end;">
                <button class="add-new-btn" onclick="openForm()"><img src="utilities/images/icons/white-plus.png" style="width: 30px; height: 30px;"><span>Add new</span></button>
            </div>

            <div id="myModal" class="modal" style="display: none;">

                <!-- Modal content -->
                <div class="modal-content" style=" width: 50% !important; border-color: #1a1a1a">
                    <span style="font-family: Bunge-Regular; font-size: 30px;">Create new user</span>
                    <form action="create-user" method="POST">
                        <div class="name-surname-container">
                            <input type="text" onkeyup="formSubmit()" name="name" placeholder="Enter name" class="input-field" style="width: 47%; margin-right: 5% ">

                            <input type="text" onkeyup="formSubmit()" name="surname" placeholder="Enter surname" class="input-field" style="width: 47%">
                        </div>

                        <div class="name-surname-container">
                            <input type="text" onkeyup="formSubmit()" name="username" placeholder="Enter username" class="input-field" style="width: 47%; margin-right: 5% ">

                            <select class="input-field" name="role" style="width: 47%">
                                <option>Select role</option>
                                <option value="1">Admin</option>
                                <option value="2">User</option>
                            </select>
                        </div>

                        <div class="name-surname-container">
                            <input type="password" onkeyup="formSubmit()" name="password" placeholder="Enter password" class="input-field" style="width: 47%; margin-right: 5% ">

                            <input type="password" onkeyup="formSubmit()" name="confirm_password" id="confirm_password" placeholder="Confirm password" class="input-field" style="width: 47%;" >
                        </div>

                        <div class="name-surname-container" style="margin-top: 30px !important;">
                            <button type="submit" class="submit-button" onclick="submitForm()" style="width: 30%; margin-right: 5% ">Create</button>
                            <button class="submit-button" style="width: 30%; background-color: beige !important; border-color: rgba(22, 83, 188, 0.9) !important; color: rgba(22, 83, 188, 0.9) !important;" ><span class="cancel">Cancel</span></button>
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

        </div>
        <div class="table-container">
            <table class="scrollable-table">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Surname</th>
                    <th>Username</th>
                    <th>Level</th>
                    <th>Score</th>
                    <th>Role</th>
                    <th>Blocked</th>
                </tr>
                </thead>
                <tbody>
                <!-- Sample rows of data -->
                <%
                    for (UserModel userModel: users
                         ) {

                %>
                <tr style="color: white !important;">
                    <td><%= userModel.getName()%></td>
                    <td><%= userModel.getSurname()%></td>
                    <td><%= userModel.getUsername()%></td>
                    <td><%= userModel.getLevel()%></td>
                    <td><%= userModel.getScore()%></td>
                    <td><%= userModel.getRole_id() %></td>
                    <td><%= userModel.isBlocked()%></td>
                    <td><button class="edit-btn" onclick="openModal(<%= userModel.getId()%>, <%= userModel.getName()%>, <%= userModel.getSurname()%>, <%= userModel.getRole_id() %>, <%= userModel.isBlocked()%>)"><img src="utilities/images/icons/edit.png"></button></td>
                </tr>

                <div id="edit-modal" class="modal" style="display: none">
                    <div class="modal-content">
                        <span style="font-family: Bunge-Regular; font-size: 30px;">User: <span id="name"></span> <span id="surname"></span> </span>
                        <form>
                            <div class="name-surname-container">
                                <input type="text" onkeyup="formSubmit()" name="level" value="Level: <%= user.getUsername()%>" class="input-field" style="width: 47%; margin-right: 5% " disabled>

                                <input type="text" onkeyup="formSubmit()" name="score" value="Score: <%= user.getRole_id()%>" class="input-field" style="width: 47%">
                            </div>

                        </form>
                    </div>
                </div>

                <%
                    }
                %>


                <!-- Add more rows as needed -->
                </tbody>
            </table>
        </div>

    </div>

</div>
</body>

<script>
    function openForm(){
        document.getElementById("myModal").style.display = "block";
    }

    var modal = document.getElementById("myModal");
    var span = document.getElementsByClassName("cancel")[0];

    span.onclick = function() {
        modal.style.display = "none";
    }

    function openModal(id, name, surname, roleId, blocked){
        document.getElementById("edit-modal").style.display = "block";
        document.getElementById("name").innerText = name;
        document.getElementById("surname").innerText = surname;
    }

    function submitForm() {
        var form = document.querySelector("#myModal form");
        var formData = new FormData(form);

        var xhr = new XMLHttpRequest();
        xhr.open("POST", "create-user", true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    // Check the response and show the appropriate modal
                    var response = xhr.responseText;
                    if (response.includes("Username is taken")) {
                        document.getElementById("username-taken-modal").style.display = "block";
                    } else if (response.includes("New user created")) {
                        document.getElementById("user-created-modal").style.display = "block";
                        closeModal(); // Close the main modal
                    }
                }
            }
        };
        xhr.send(formData);
    }


</script>

</html>

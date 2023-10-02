<%@ page import="models.UserModel" %>
<%@ page import="java.util.List" %>
<%@ page import="apis.UserModelAPIs" %>
<%@ page import="data.DbConnectionJPA" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserModelAPIs apIs = new DbConnectionJPA();
%>

<%
    if(session.getAttribute("addNewUser") != null){
%>
<jsp:useBean id="new_user" class="models.UserModel"></jsp:useBean>
<jsp:setProperty name="new_user" property="name"></jsp:setProperty>
<jsp:setProperty name="new_user" property="surname"></jsp:setProperty>
<jsp:setProperty name="new_user" property="username"></jsp:setProperty>
<jsp:setProperty name="new_user" property="password"></jsp:setProperty>
<jsp:setProperty name="new_user" property="role_id"></jsp:setProperty>
<%
        apIs.createUser(new_user);
    }
%>

<%
    UserModel user = new UserModel();
    if(session.getAttribute("user") != null){
        user = (UserModel) session.getAttribute("user");
    }

    //2 is for all users (blocked and unblocked)
    List<UserModel> users = apIs.getAllUsers();
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
            <button class="btn-settings" onclick="logOut()"><img src="utilities/images/icons/leave_icon.png">Logout</button>
        </div>
    </div>

    <div class="main-container">
        <div class="all-users-container">
            <div class="btn-container">
                <div>
                    <h1>List of users</h1>
                </div>
                <div class="btn" style="width: 20%; display: flex; align-items: end; justify-content: end;">
                    <button class="add-new-btn" onclick="window.location.href='add-new-user.jsp'"><img src="utilities/images/icons/white-plus.png" style="width: 30px; height: 30px;"><span>Add new user</span></button>
                </div>

            </div>
            <div class="table-container">
                <table class="scrollable-table">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>Surname</th>
                        <th>Username</th>
                        <th>Score</th>
                        <th>Role</th>
                        <th>Delete</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- Sample rows of data -->
                    <%
                        for (UserModel userModel: users
                        ) {
                            String role = userModel.getRole_id() == 1 ? "admin" : "user";

                    %>
                    <tr style="color: white !important">
                        <td><%= userModel.getName()%></td>
                        <td><%= userModel.getSurname()%></td>
                        <td><%= userModel.getUsername()%></td>
                        <td><%= userModel.getScore()%></td>
                        <td><%= role%></td>
                        <form style="display: none;" action="/deleteUser" method="POST">
                            <input type="number" name="id" value="<%= userModel.getId()%>" style="display: none">
                            <td><button type="submit" style="background-color: rgba(0, 0, 0, 0);"><img src="utilities/images/icons/delete.png" style="cursor: pointer;"></button></td>
                        </form>

                    </tr>

                    <%
                        }
                    %>

                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>
</body>

<script>

    function logOut(){
        <%
            session.removeAttribute("user");
        %>

        window.location.href = "/sign_in";
    }

</script>

</html>
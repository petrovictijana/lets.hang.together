<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if(session.getAttribute("500") != null){
        session.removeAttribute("500");
    }

    if(session.getAttribute("taken") != null){
        session.removeAttribute("taken");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="styles/common.css">
    <link rel="stylesheet" href="styles/login.css">

</head>

<body>
<div class="overlay-container">
    <div class="label">
        <span>Let's HANG together</span>
    </div>

    <div class="form-container">
        <span class="form-label">SIGN IN</span>

        <form class="form" action="login" method="GET">
            <input type="text" name="username" placeholder="Enter username" class="input-field">

            <input type="password" name="password" placeholder="Enter password" class="input-field">

            <%
                if(session.getAttribute("unauthorized") != null){
            %>

            <div id="myModal" class="modal" style="display: block">

                <!-- Modal content -->
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <p>Wrong username or password! Try again!</p>
                </div>

            </div>
            <%
                }
            %>

            <a href="/registration_form" class="link-registration">Don't have account? Create one</a>

            <button type="submit"class="submit-button"> SIGN IN </button>
        </form>

    </div>
</div>



</body>

<script>
    var modal = document.getElementById("myModal");
    var span = document.getElementsByClassName("close")[0];

    span.onclick = function() {
        modal.style.display = "none";
        sessionStorage.clear();
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
        sessionStorage.clear();
    }
</script>

</html>

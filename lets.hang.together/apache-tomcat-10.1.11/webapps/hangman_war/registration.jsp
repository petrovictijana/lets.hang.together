<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 7/30/2023
  Time: 4:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  if(session.getAttribute("unauthorized") != null){
    session.removeAttribute("unauthorized");
  }
%>
<html>
<head>
    <title>Registration</title>
    <link rel="stylesheet" href="styles/common.css">
    <link rel="stylesheet" href="styles/registration.css">
</head>
<body onload="buttonDisabledCheck()">
  <div class="overlay-container">
    <div class="label">
      <span>Let's HANG together</span>
    </div>


    <div class="form-container">
      <span class="form-label">CREATE ACCOUNT</span>

      <form class="form" action="registration" method="POST">
        <div class="name-surname-container">
          <input type="text" onkeyup="formSubmit()" name="name" placeholder="Name" class="input-field" style="width: 47%; margin-right: 5% ">

          <input type="text" onkeyup="formSubmit()" name="surname" placeholder="Surname" class="input-field" style="width: 47%">
        </div>

        <input type="text" onkeyup="formSubmit()" name="username" placeholder="Enter username" class="input-field">

        <input type="password" onkeyup="formSubmit()" name="password" placeholder="Enter password" class="input-field">

        <input type="password" onkeyup="formSubmit()" name="confirm_password" id="confirm_password" placeholder="Confirm password" class="input-field" >
        <div class="checkboxes-container">
          <div class="checkbox">
            <input type="checkbox" onchange="formSubmit()" id="safety_policy" name="safety_policy" class="checkboxes" style="height: 20px; width: 20px; margin-right: 10px"> I agree with<a href="policy_pages/policy.jsp" style="color: dodgerblue; padding-left: 7px">safety policy</a>
          </div>
          <div class="checkbox">
            <input type="checkbox" onchange="formSubmit()" id="age_number" name="age_number" class="checkboxes" style="height: 20px; width: 20px; margin-right: 10px">  I am more than 12 years old
          </div>
        </div>

        <%
          String message = "";
          if(session.getAttribute("taken") != null)
            message = "Username is already taken!";
          else if(session.getAttribute("500") != null)
            message = "Oops... Something went wrong. Please try again!";
        %>

        <%
          if(message != ""){
        %>

        <div id="myModal" class="modal" style="display: block">

          <!-- Modal content -->
          <div class="modal-content">
            <span class="close">&times;</span>
            <p><%= message %></p>
          </div>

        </div>

        <%
          }
        %>


        <a href="index.jsp" class="link-registration">Already have an account? Sign in</a>
        <button type="submit"class="submit-button" id="submit-button" disabled> CREATE </button>
      </form>

    </div>
  </div>

</body>

<script>
  function buttonDisabledCheck() {
    var btn = document.getElementById("submit-button");
    if (btn.disabled == true) {
      btn.style.opacity = "0.5";
      btn.style.cursor = "not-allowed";
    }
    else{
      btn.style.opacity = "1";
      btn.style.cursor = "cursor";
    }
  }

  function formSubmit(){
    var name = document.getElementsByName("name")[0].value;
    var surname = document.getElementsByName("surname")[0].value;
    var username = document.getElementsByName("username")[0].value;
    var password = document.getElementsByName("password")[0].value;
    var confirm_password = document.getElementsByName("confirm_password")[0].value;
    var safety_policy = document.getElementById("safety_policy");
    var age_number = document.getElementById("age_number");
    var btn = document.getElementById("submit-button");


    if(name.trim() != "" && surname.trim() != "" && username.trim() != "" && password.trim() != "" && confirm_password.trim() != "" && safety_policy.checked == true && age_number.checked == true){
      if(password === confirm_password){
        btn.disabled = false;
        document.getElementById("confirm_password").style.border = "3px solid rgb(0, 230, 0)";
      }
      else{
        document.getElementById("confirm_password").style.border = "3px solid rgb(230, 0, 0)";
        btn.disabled = true;
      }
    }
    else{
      btn.disabled = true;
      if(password != "" && confirm_password != "" && password != confirm_password)
        document.getElementById("confirm_password").style.border = "3px solid rgb(230, 0, 0)";
      else if(password != "" && confirm_password != "" && password == confirm_password)
        document.getElementById("confirm_password").style.border = "3px solid rgb(0, 230, 0)";
    }

    buttonDisabledCheck();
  }

  //Modals
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

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="java.lang.*" %>

<%
  String message = "";

	if (request.getParameter("msg") != null)
	{
		if(request.getParameter("msg").equals("pls_login")){
			message = "You need to be logged in as a manager to view this page";
		}
	}


  //perform db lookup for username & password using JSTL

  // Check that the submitted username & password are not null
  boolean login_attempt = request.getParameter("username") == null ? false : true;
  login_attempt &= request.getParameter("password") == null ? false : true;
	
  if(login_attempt){
    pageContext.setAttribute(
      "managerNumber",
      request.getParameter("username"));
    pageContext.setAttribute(
      "managerPassword",
      request.getParameter("password"));

      // Add jstl code here...
  %>
      <sql:query var="result">
        select * from manager where
          manager_number = "${managerNumber}" and
          passwd = MD5("${managerPassword}");
      </sql:query>
      <c:set var="numResults" scope="page" value="${result.rowCount}"/>
<c:set var="userRealName" scope="page" value="${result.getRows()[0].firstname} ${result.getRows()[0].surname}" />
  <%
  // If there's only one result in the users table which has the username &
  // password combination then...
  //int val = ((Integer)pageContext.getAttribute("numResults")).intValue();
  String value = null;
  try{
      value = pageContext.getAttribute("numResults").toString();
      out.println(value.equals("1"));
      out.println("'"+value+"' knd");
  } catch(NullPointerException e) {
    out.println("aint werkin");
  }
  if(value.equals("1")){
    // set the session:username to the user's username, to be used later on...
    session.setAttribute(
      "username",
      request.getParameter("username"));

    // Set user role to be customer
    session.setAttribute(
      "user_role",
      "manager"
    );
    session.setAttribute("user_realname", pageContext.getAttribute("userRealName"));

    // Handle dynamic redirect
    if(request.getParameter("dest") == null){
      response.sendRedirect("manage.jsp");
    } else {
      response.sendRedirect(request.getParameter("dest"));
    }
  } else{
    // Message to display in case of a failed login attempt.
    message = new String("<div class='login_error_message'>Login attempt failed</div>");
  }
  }

// If it's not a login attempt, display this page
%>


<!DOCTYPE html>
<html>
	<head>
		<!-- INCLUDE HTML HEADER HERE -->
		<%@ include file="file_header.jsp" %>
		<title>Login</title>
	</head>
	<body>
		<%@ include file="body_header.jsp" %>
		<div id="content">
			<div id="deploy_timestamp">
				<%@ include file="timestamp.html" %>
			</div>
			<h1>Manager Login</h1>
      <form action="" method="POST" id="user_login_form">
				<script type="text/javascript">
				// Validation stuff
				function validate_form(obj)
				{
					if(!isNaN(document.getElementById("username_input").value) && document.getElementById("password_input").value){
						obj.parent.submit();
					} else {
						alert("Invalid Username and/or Password");
					}      <form action="" method="POST" id="user_login_form">
				}
				</script>

        <label>Username:</label> <input name="username" id="username_input"/><br/>
        <label>Password:</label> <input name="password" type="password" id="password_input"/><br/>
        <button onclick="validate_form(this)">Login</button>
      <% out.println(message); %>
      </form>
      <a href="session_login.jsp">Customer Login</a>
		</div>


		<!-- INCLUDE FOOTER CONTENT HERE -->
	</body>
</html>

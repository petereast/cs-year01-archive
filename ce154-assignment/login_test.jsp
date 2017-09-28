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
			<h1>User Login</h1>
      <form action="" method="POST" id="user_login_form">
				<script type="text/javascript">
				// Validation stuff
				function validate_form(obj)
				{
					if(!isNaN(document.getElementById("username_input").value) && document.getElementById("password_input").value){
						obj.parent.submit();
					} else {
						alert("Invalid");
					}
				}
				</script>

        <label>Username:</label> <input name="username" id="username_input"/><br/>
        <label>Password:</label> <input name="password" type="password" id="password_input"/><br/>
        <button onclick="validate_form(this)">Login</button>
      </form>
		</div>


		<!-- INCLUDE FOOTER CONTENT HERE -->
	</body>
</html>

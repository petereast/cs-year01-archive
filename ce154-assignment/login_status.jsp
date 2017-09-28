<div class="login_status">
	<%
		String pageName = request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/")+1);
		if ( session.getAttribute( "username" ) == null )
		{
			out.println("Not Logged in");
	%>
		<form action="session_login.jsp" method="GET">
			<input type="hidden" name="dest" value="<%=pageName %>"/>
			<input type="Submit" value="Login" />
		</form>
	<%
		} else {
			out.println("Logged in as " + session.getAttribute( "user_realname" ));
			if(session.getAttribute("user_role") == "manager"){
				out.println("(manager)<br><form action=\"manage.jsp\"><input type=\"submit\" value=\"View Management Page\"/></form>");
			}
		%>
			<form action="session_logout.jsp" method="POST">
				<input type="submit" value="Logout"/>
			</form>
		<%
		}
	%>

</div>

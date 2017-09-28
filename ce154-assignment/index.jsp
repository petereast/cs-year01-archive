<!DOCTYPE html>
<html>
	<head>
		<!-- INCLUDE HTML HEADER HERE -->
		<%@ include file="file_header.jsp" %>
		<title>Home</title>
	</head>
	<body>
		<%@ include file="body_header.jsp" %>
		<div id="content">
			<div id="deploy_timestamp">
				<%@ include file="timestamp.html" %>
			</div>

			<h1>Welcome!</h1>
			<a href="reset.jsp">Reset Database</a>
		</div>
		<!-- include a link to reset.jsp -->

		<!-- INCLUDE FOOTER CONTENT HERE -->
	</body>
</html>

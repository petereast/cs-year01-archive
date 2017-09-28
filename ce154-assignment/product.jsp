<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="java.lang.*" %>

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
    			<h1>Product: </h1>
					<h2>Price: </h2>
					<button><a href="purchase.jsp">Purchase</a></button>
		</div>


		<!-- INCLUDE FOOTER CONTENT HERE -->
	</body>
</html>

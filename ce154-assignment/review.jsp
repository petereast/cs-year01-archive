<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="java.lang.*" %>

<%

// Check that the user is logged in
String id = "";
if(session.getAttribute("username") == null){
	response.sendRedirect("session_login.jsp?msg=pls_login");
}

String errorMessage = "";
if (request.getParameter("d")!= null){
	id = request.getParameter("d");
	
	if(request.getParameter("mode") != null)
	{
		//A review is being submitted
		
		pageContext.setAttribute("userID", session.getAttribute("username"));
		pageContext.setAttribute("itemCode", id);
		pageContext.setAttribute("rating", request.getParameter("score"));
		try{
		%>
		<sql:update>
			INSERT INTO review(customer_number, item_code, rating) VALUES(
			${userID}, "${itemCode}", ${rating});		
		</sql:update>
		<%
		} catch(Exception e){
			errorMessage = "An error occoured - have you already reviewed this item?";
		}
		
		
	}
} else {
	errorMessage = "Error: no/invalid product selected";
}

%>

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
			
			<h2>Review Product</h2>
			<%=errorMessage%>
			<%
			if(request.getParameter("mode") == null)
			{
			%>
			<!-- product information here -->
			
			<form action="" method="POST">
				<input type="hidden" name="mode" value="submit"/>
				<input type="hidden" name="d" value="<% out.println(id);%>"/>
				Please rate this product: <br/>
				<input type="radio" name="score" value="1"> 1 <br/>
				<input type="radio" name="score" value="2"> 2 <br/>
				<input type="radio" name="score" value="3"> 3 <br/>
				<input type="radio" name="score" value="4"> 4 <br/>
				<input type="radio" name="score" value="5"> 5 <br/>
				<input type="submit" value="Submit Review"/>											
			</form>
			<%
			} else {
				out.println("<h2>Thanks for the review!</h2><p>Would you like to purchase this product?<br><a href='purchase.jsp?d="+id+"'>Purchase</a></p>");
			}
			
			%>
		</div>
		<!-- include a link to reset.jsp -->

		<!-- INCLUDE FOOTER CONTENT HERE -->
	</body>
</html>

<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
	<head>
		<!-- INCLUDE HTML HEADER HERE -->
		<%@ include file="file_header.jsp" %>
		<title>Books</title>
	</head>
	<body>
		<%@ include file="body_header.jsp" %>
		<div id="content">
			<div id="deploy_timestamp">
				<%@ include file="timestamp.html" %>
			</div>

			<h1>Books</h1>

			<!-- Display product information here -->
			
    		<sql:query var="result">
      			select * from inventory
      			where item_group = (select distinct group_code from inventory_group where group_name="Books");
    		</sql:query>

    		<table border="1" width="100%">
      		<tr>
        		<th>Code</th>
         		<th>Author</th>
         		<th>Description</th>
			<th>Price</th>
     		</tr>

      	<c:forEach var = "row" items = "${result.rows}">
        	<tr>
          		<td><c:out value = "${row.item_name}"/></td>
          		<td><c:out value = "${row.item_author}"/></td>
          		<td><c:out value = "${row.item_description}"/></td>
			<td>&pound;<c:out value = "${row.item_price}"/></td>
          		<td><img src='img/<c:out value = "${row.item_image_loc}"/>' height="128px"/></td>
			<td><a class="product_purchase" href='purchase.jsp?d=<c:out value = "${row.item_code}"/>'>Buy Product</a></td>
			<td><a class="product_purchase" href='review.jsp?d=<c:out value = "${row.item_code}"/>'>Review Product</a></td>
        	</tr>
      	</c:forEach>

			
		</div>


		<!-- INCLUDE FOOTER CONTENT HERE -->
	</body>
</html>

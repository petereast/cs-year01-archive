<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%
	if(session.getAttribute("username") != null){
		if(session.getAttribute("user_role") != "manager"){
			response.sendRedirect("manager_login.jsp?msg=pls_login");
		}
	}

%>

<!DOCTYPE html>
<html>
  <head>
    <%@ include file="file_header.jsp" %>
    <title>Management</title>
  </head>
  <body>
  	<%@ include file="body_header.jsp" %>
    <div id="content">
    <h1>Management</h1>
    <h2>Database Access</h2>
    <form name="db_selector" action="" method="get">
    
    <select name="table">
    	<option>inventory_group</option>
    	<option>inventory</option>
    	<option>customer</option>
    	<option>customer_order</option>
    	<option>order_item</option>
    	<option>manager</option>
    	<option>review</option>
    	<option>promotion_code</option>
    </select> 
    
    <input type="submit"/>
    
    </form>

	<%
	String table = "";	
	 if(request.getParameter("table") != null){
		table = request.getParameter("table");
		pageContext.setAttribute("table", table);
	%>

    <sql:query var="result">
      select * from ${table};
    </sql:query>

    <table border="1" width="100%">
    <c:forEach var = "row" items = "${result.rows}">
        <tr>
          <c:forEach var ="item" items = "${row}">
          	<td>
          		<c:out value="${item}"/>
          	</td>
          	</c:forEach>
        </tr>
      </c:forEach>
    </table>
    <% } else{
    	out.println("please select a table to view");
    }
    
    %>
    </div>
  </body>
</html>

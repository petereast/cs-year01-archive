<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="java.lang.*" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Example 91</title>
  </head>
  <body>
    <h3>Basic login with customer number and password
        checked in SQL database</h3>
    <p>
      NB You must enter a <em>customer number</em> and valid
      password for it.
    </p>
    <%
      if ( session.isNew() )
      {
        out.println( "<h3>NB: New session starting</h3>" );
      }
      else
      {
        session.invalidate();
    %>
        <jsp:forward page="example91.jsp" />
    <%
      }
    %>

    <% 
      if ( request.getParameter( "username" ) == null )
      {
        out.println( "<h3>Please login:</h3>" );
      }
      else
      {
        pageContext.setAttribute(
          "customerNumberString",
          request.getParameter( "username" ) );
        pageContext.setAttribute(
          "customerPasswordString",
          request.getParameter( "password" ) );
    %>

        <sql:query var="result">
          select * from customer where 
            customer_number = "${customerNumberString}" and 
            passwd = MD5("${customerPasswordString}");
        </sql:query>
        <c:set var = "numResults" scope="page" value = "${result.rowCount}"/>


    <%
        Object o = pageContext.getAttribute( "numResults" );
        /* Above line not used. */
        Integer obj = new Integer( 1 );
        int i = obj.intValue();

        if ( pageContext.getAttribute( "numResults" ).intValue().equals( obj ) )
        {
          String usernameID = new String( "username" );
          String usernameVAL =
             new String( request.getParameter( "username" ) );
          session.setAttribute(
            usernameID, usernameVAL );
    %>
          <jsp:forward page="example92.jsp" />
    <%
        }
        else
        {
          out.println( "<h3>Login failed, please try again:</h3>" );
        }
      }
    %>

    <form action="example91.jsp" method="POST">
      Customer Number: <input type="text" name="username">
      <br />
      Password: <input type="text" name="password" />
      <br />
      <input type="submit" value="Login" />
    </form>
  </body>
</html>

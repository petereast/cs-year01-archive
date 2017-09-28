<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.math.*" %>
<%

// Check that the user is logged in

if(session.getAttribute("username") == null){
	response.sendRedirect("session_login.jsp?msg=pls_login");
}	

String itemCode;
String promo = "";
double reduction = 0;
double price = 0.0;

String message = "";
// Perform request Handle
if(request.getParameter("intent") != null) {

	if(request.getParameter("intent").equals("add_promo")){
		out.println("<!-- Adding promo code -->");
		
		try{
			promo = session.getAttribute("promo").toString();
		}catch (NullPointerException e){
			promo = "";
		}
		try{
			reduction = (double)session.getAttribute("reduction");
		
		} catch (NullPointerException e){
			reduction = 0;
		}

	// Find the promo code in the database
	// setup page context
	String code = request.getParameter("promo_code").toString();
	pageContext.setAttribute("promoCode", code);
	
	
	//use JSTL to get promo code from database?
	%>
		<sql:query var="result">
			select distinct * from promotion_code
			where code = "${promoCode}";
		</sql:query>
		<c:set var="discountValue" scope="page" value="${result.getRows()[0].discount}"/>
	<%
	
	if(pageContext.getAttribute("discountValue") != null && 
		!(promo.contains(code)))
	{
		promo += "#"+code;
		session.setAttribute("promo", promo);
		reduction += ((Integer)pageContext.getAttribute("discountValue")).intValue();
		session.setAttribute("reduction", reduction);
	}	
	
	// if the promo code is in the database, add it to the list
	
	
	} else if(request.getParameter("intent").equals("make_purchase"))
	{
		// Check if the item is in stock or not...
		boolean instock = false;
		if(session.getAttribute("itemInStock") != null)
		{	
			instock = (boolean)session.getAttribute("itemInStock");
		}
		// Update the database tables as follows: 
		//	Update the stock/orders information in inventory
		//	Update customer_order
		//	Update order_item	
		if(request.getParameter("d") != null && session.getAttribute("item_price") != null && instock){
			itemCode = request.getParameter("d");

			price = (double)session.getAttribute("item_price");
			
			pageContext.setAttribute("itemCode", itemCode);
			pageContext.setAttribute("itemPrice", price);
				
			pageContext.setAttribute("customer_number",session.getAttribute("username"));
			
		%>
		<c:out value="${customer_number}"/>
		<sql:update var="result">
			INSERT INTO customer_order (order_date, delivered, shipping_date, customer_number) VALUES(
			NOW(),
			false,
			ADDDATE(NOW(), INTERVAL 3 DAY),
			${customer_number}
			);			
		</sql:update>
		<sql:update var="result2">
			INSERT INTO order_item VALUES(
	"${itemCode}",
	${itemPrice},
	(SELECT max(order_number) FROM customer_order),
	1
);
		</sql:update>
		<sql:update var="result3">
			UPDATE inventory
	SET item_stock_count = item_stock_count-1,
		item_order_count = item_order_count+1
	WHERE item_code = "${itemCode}";
		</sql:update>
	<%
		response.sendRedirect("purchase_success.jsp");
		out.println("<!-- Order successful! -->");
		
	} else { out.println("<!-- Order unsuccessful! -->");}
		// When the purchase completes, remove promo information
		session.setAttribute("promo", null);
		session.setAttribute("reduction", null);
		session.setAttribute("price", null);
	}
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
			<h1>Purchase</h1>
			<!-- discount code & purchase confirmation -->

			<div id="product_information">
			<!-- Display product information here -->
			
			<%
				if((itemCode = request.getParameter("d")) != null){
					pageContext.setAttribute("itemCode", itemCode);
			%>
			<sql:query var="result">
				select * from inventory
				where item_code = "${itemCode}";			
			</sql:query>
			<c:set var="itemPrice" scope="page" value="${result.getRows()[0].item_price}"/>
			<c:set var="itemStock" scope="page" value="${result.getRows()[0].item_stock_count}"/>
			<span id="price">
			<%
			
			if(pageContext.getAttribute("itemStock") != null){
				session.setAttribute("itemInStock", ((int)pageContext.getAttribute("itemStock")) <= 0 ? false: true);
			
			}

			double itemPrice = ((BigDecimal)(pageContext.getAttribute("itemPrice"))).doubleValue();
					if(reduction!=0)
					{
						
						price = itemPrice*(1.0-((reduction/100)));
						double percentReduction = 1.0 - (reduction/100);
					} else {
						price = itemPrice;
					}
					
					session.setAttribute("item_price", price);
					
					out.println(String.format("&pound;%.2f", price));
				} else {
					out.println("Invalid product code!");
				}
			%>
			<h2><c:out value="${result.getRows()[0].item_name}" /></h2><br>
			<c:out value="${result.getRows()[0].item_description}" /><br>
			<img height="256px" src='<c:out value="img/${result.getRows()[0].item_image_loc}"/>'/><br>
			</span>
			</div>

			<div id="applied_promo_container">
					<!-- Applied discount codes will appear here -->
					<%
						for(String code: promo.split("#")){
							out.println("<p>"+code+"</p>");
						}
						if(!promo.equals("")){
						out.println("reduction: "+reduction);
						}
					%>
			</div>
			
			<form id="discount_applicator" action="" method="POST">
				<h2>Promo Code</h2>
				<p>Add your promotion codes here:</p>
				<input type="hidden" name="intent" value="add_promo"/>
				<input name="promo_code"/>
				<input type="submit" value="Apply code"/> 
			</form>
			<form id="product_form" action="" method="POST">
				<input type="hidden" name="intent" value="make_purchase" />
				<% if(!(boolean)session.getAttribute("itemInStock")){out.println("Sorry! Out of stock :("); }%>
				<input type="submit" value="Confirm Purchase" <% if(!(boolean)session.getAttribute("itemInStock")){out.println("disabled='true'"); }%>/>
			</form>
		</div>


		<!-- INCLUDE FOOTER CONTENT HERE -->
	</body>
</html>

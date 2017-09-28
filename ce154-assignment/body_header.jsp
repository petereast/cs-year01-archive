<div class="header top" id="b">
	<nav>
		<a href="index.jsp">Home</a>
		<a href="books.jsp">Books</a>
		<a href="cds.jsp">CDs</a>
		<a href="games.jsp">Games</a>
		<a href="dvds.jsp">DVDs</a>
	</nav>
	<form name="search" action="search.jsp" method="GET">
		<input type="hidden" name="intent" value="search"/>
		<input name="s"/>
		<input type="submit" value="Search"/>		
	</form>
</div>

<div class="pane left" id="a">
	<h1>UoE Media ltd</h1>
	<%@ include file="login_status.jsp" %>
</div>

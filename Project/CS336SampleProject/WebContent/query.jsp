<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Beer Query</title>
</head>
<body>
<%
	try {
		List<String> list = new ArrayList<>();
		// Get the database connection
		ApplicationDB db  = new ApplicationDB();
		Connection    con = db.getConnection();

		// Create a SQL statement
		Statement stmt = con.createStatement();
		// Get the combobox from the index.jsp
		String entity = request.getParameter("price");
		// Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
		String str = "SELECT * FROM sells WHERE price <= " + entity;
		// Run the query against the database.
		ResultSet result = stmt.executeQuery(str);

		// Make an HTML table to show the results in:
		out.print("<table>");

		// make a row
		out.print("<tr>");
		// make a column
		out.print("<td>");
		// print out column header
		out.print("bar");
		out.print("</td>");
		// make a column
		out.print("<td>");
		out.print("beer");
		out.print("</td>");
		// make a column
		out.print("<td>");
		out.print("price");
		out.print("</td>");
		out.print("</tr>");

		// parse out the results
		while (result.next()) {
			// make a row
			out.print("<tr>");
			// make a column
			out.print("<td>");
			// Print out current bar name:
			out.print(result.getString("bar"));
			out.print("</td>");
			out.print("<td>");
			// Print out current beer name:
			out.print(result.getString("beer"));
			out.print("</td>");
			out.print("<td>");
			// Print out current price
			out.print(result.getString("price"));
			out.print("</td>");
			out.print("</tr>");

		}
		out.print("</table>");

		// close the connection.
		con.close();

	}
	catch (Exception e) {
		e.printStackTrace();
	}
%>

</body>
</html>
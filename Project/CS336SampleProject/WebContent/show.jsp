<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Show Result</title>
</head>
<body>
<%

	try {
		// Get the database connection
		ApplicationDB db  = new ApplicationDB();
		Connection    con = db.getConnection();

		// Create a SQL statement
		Statement stmt = con.createStatement();
		// Get the selected radio button from the index.jsp
		String entity = request.getParameter("command");
		// Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		String str = "SELECT * FROM " + entity;
		// Run the query against the database.
		ResultSet result = stmt.executeQuery(str);

		// Make an HTML table to show the results in:
		out.print("<table>");

		// make a row
		out.print("<tr>");
		// make a column
		out.print("<td>");
		// print out column header
		out.print("name");
		out.print("</td>");
		// make a column
		out.print("<td>");
		// depending on the radio button selection make a column header for Manufacturer if the beers table was selected and Address if the bars table was selected
		if (entity.equals("beers")) {
			out.print("manf");
		}
		else {
			out.print("addr");
		}
		out.print("</td>");
		out.print("</tr>");

		// parse out the results
		while (result.next()) {
			// make a row
			out.print("<tr>");
			// make a column
			out.print("<td>");
			// Print out current bar or beer name:
			out.print(result.getString("name"));
			out.print("</td>");
			out.print("<td>");
			// Print out current bar/beer additional info: Manufacturer or Address
			if (entity.equals("beers")) {
				out.print(result.getString("manf"));
			}
			else {
				out.print(result.getString("addr"));
			}
			out.print("</td>");
			out.print("</tr>");

		}
		out.print("</table>");

		// close the connection.
		db.closeConnection(con);
	}
	catch (Exception e) {
		out.print(e);
	}
%>

</body>
</html>
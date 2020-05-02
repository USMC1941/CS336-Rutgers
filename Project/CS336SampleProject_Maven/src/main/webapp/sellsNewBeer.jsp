<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Statement" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
   <title>Sell New Beer</title>
</head>
<body>
<%
   try {
      // Get the database connection
      ApplicationDB db  = new ApplicationDB();
      Connection    con = db.getConnection();
      // Create a SQL statement
      Statement stmt = con.createStatement();
      // Get parameters from the HTML form at the HelloWorld.jsp
      String newBar  = request.getParameter("bar");
      String newBeer = request.getParameter("beer");
      float  price   = Float.parseFloat(request.getParameter("price"));
      // Make an insert statement for the Sells table:
      String insert = "INSERT INTO sells(bar, beer, price) VALUES (?, ?, ?)";
      // Create a Prepared SQL statement allowing you to introduce the parameters of the query
      PreparedStatement ps = con.prepareStatement(insert);
      // Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
      ps.setString(1, newBar);
      ps.setString(2, newBeer);
      ps.setFloat(3, price);
      // Run the query against the DB
      ps.executeUpdate();
      // Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
      con.close();
      out.print("Insert succeeded!");
   }
   catch (Exception ex) {
      out.print(ex);
      out.print("Insert failed :()");
   }
%>
</body>
</html>

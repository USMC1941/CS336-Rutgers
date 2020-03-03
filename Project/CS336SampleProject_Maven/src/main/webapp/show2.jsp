<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="com.cs336.ApplicationDB" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
   <title>Show Result 2</title>
</head>
<body>
<% try {
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
%>

<!--  Make an HTML table to show the results in: -->
<table>
   <tr>
      <td>Name</td>
      <td>
         <%
            if (entity.equals("beers")) {
               out.print("manf");
            }
            else {
               out.print("addr");
            }
         %>
      </td>
   </tr>
   <%
      // parse out the results
      while (result.next()) { %>
   <tr>
      <td><%= result.getString("name") %>
      </td>
      <td>
         <% if (entity.equals("beers")) { %>
         <%= result.getString("manf")%>
         <% }
         else { %>
         <%= result.getString("addr")%>
         <% } %>
      </td>
   </tr>


   <% }
      // close the connection.
      db.closeConnection(con);
   %>
</table>


<%
   }
   catch (Exception e) {
      out.print(e);
   }
%>


</body>
</html>

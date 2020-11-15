<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
   <title>Beer World</title>
</head>
<body>
Hello World1 <!-- the usual HTML way -->

<% out.println("Hello World2"); %> <!-- output the same thing, but using jsp programming -->

<!--
If jsp cannot compile on Tomcat because of Java version, follow this:
https://stackoverflow.com/a/41588031
-->
<br>

<!--
Show HTML form to:
	i) Display something
	ii) Choose an action via a radio button
forms are used to collect user input.
The default method when submitting form data is GET. However, when GET is used, the submitted form data will be visible in the page address field.
-->
<form method="post" action="show.jsp">
   <!-- note the show.jsp will be invoked when the choice is made -->
   <!-- The next lines give HTML for radio buttons being displayed -->
   <input type="radio" name="command" value="beers"/>Let's have a beer!
   <br>
   <input type="radio" name="command" value="bars"/>Let's go to a bar!
   <!-- when the radio for bars is chosen, then 'command' will have value 'bars', in the show.jsp file, when you access request.parameters -->
   <br>
   <input type="submit" value="submit"/>
</form>
<br>

A bar wants to sell a beer! Type the bar, the beer and the price of the beer:
<br>
<form method="post" action="sellsNewBeer.jsp">
   <table>
      <tr>
         <td>Bar</td>
         <td><input type="text" name="bar"></td>
      </tr>
      <tr>
         <td>Beer</td>
         <td><input type="text" name="beer"></td>
      </tr>
      <tr>
         <td>Price</td>
         <td><input type="number" name="price" min="0"></td>
      </tr>
   </table>
   <input type="submit" value="Add the selling beer!">
</form>
<br>


Alternatively, lets type in a new bar, a new beer, and a price that this bar will sell the beer for.
<br>
<form method="post" action="newBarBeerPrice.jsp">
   <table>
      <tr>
         <td>Bar</td>
         <td><input type="text" name="bar"></td>
      </tr>
      <tr>
         <td>Beer</td>
         <td><input type="text" name="beer"></td>
      </tr>
      <tr>
         <td>Price</td>
         <td><input type="number" name="price" min="0"></td>
      </tr>
   </table>
   <input type="submit" value="Add me!">
</form>
<br>

Or we can query the beers with price:
<br>
<form method="post" action="query.jsp">
   <select name="price" size=1>
      <option value="3.0">$3.0 and under</option>
      <option value="5.0">$5.0 and under</option>
      <option value="8.0">$8.0 and under</option>
   </select>&nbsp;<br>
   <input type="submit" value="Submit">
</form>
<br>

</body>
</html>

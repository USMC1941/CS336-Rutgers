# Session Objects

In a web application, a web server may be responding to several clients at the same time. Session tracking is a way by which the server can identify the client. Since the HTTP protocol is stateless,  the client needs to open a separate connection every time it interacts with the server, and the server treats each request as a new request.

In order to identify the client, the server needs to maintain the client's state. There are several session tracking techniques. For the purpose of this project we will focus on the Session Object. (Object <--> think Java object, sort of)

## Session Object

A Session object is the representation of one user session. A user's Session starts when the user opens a browser and sends the first request to the server. The Session object is available in all the requests (in the entire user session) so attributes stored in the Http session will be available in any jsp (which means in any page of the web application).

When a session is created, the server generates a unique ID and attaches that ID to the session. The server sends back this ID to the client and from there on, the browser sends back this ID with every request of that user to the server; the  server then identifies the client using this.

### How to get/create a Session Object

By calling either the [`getSession()`](https://tomcat.apache.org/tomcat-9.0-doc/servletapi/javax/servlet/http/HttpServletRequest.html#getSession--) method on the [`HttpServletRequest`](https://tomcat.apache.org/tomcat-9.0-doc/servletapi/javax/servlet/http/HttpServletRequest.html) object 
(remember, this is an implicitly available object)
```java
HttpSession session = request.getSession();
```

or the [`getSession(boolean)`](https://tomcat.apache.org/tomcat-9.0-doc/servletapi/javax/servlet/http/HttpServletRequest.html#getSession-boolean-) method
```java
HttpSession session = request.getSession(true);
```
### How to destroy a Session Object
[`invalidate()`](https://tomcat.apache.org/tomcat-9.0-doc/servletapi/javax/servlet/http/HttpSession.html#invalidate--) used to kill the user session, especially used when the end-user logs off. To invalidate the session use:
```java
session.invalidate();
```

### Other important methods defined for interface [`HttpSession`](https://tomcat.apache.org/tomcat-9.0-doc/servletapi/javax/servlet/http/HttpSession.html):

[`setAttribute()`](https://tomcat.apache.org/tomcat-9.0-doc/servletapi/javax/servlet/http/HttpSession.html#setAttribute-java.lang.String-java.lang.Object-) is used to store an attribute + value in session. 
```java
void setAttribute(String attributeName, Object value)
```

[`getAttribute()`](https://tomcat.apache.org/tomcat-9.0-doc/servletapi/javax/servlet/http/HttpSession.html#getAttribute-java.lang.String-) is used to get the value stored in a session under the attribute name. Remember the return type is [`Object`](https://docs.oracle.com/en/java/javase/12/docs/api/java.base/java/lang/Object.html). That means you can store any type of object in the session.

```java
Object getAttribute(String attributeName)
```

[`removeAttribute()`](https://tomcat.apache.org/tomcat-9.0-doc/servletapi/javax/servlet/http/HttpSession.html#removeAttribute-java.lang.String-) is used to remove the attribute from session.
```java
void removeAttribute(String attributeName)
```

[`isNew()`](https://tomcat.apache.org/tomcat-9.0-doc/servletapi/javax/servlet/http/HttpSession.html#isNew--) returns true if server does not find any state of the client.
```java
boolean isNew()
```


Note: Browser session and server sessions are different. Browser session is client session which starts when you open the browser and gets destroyed when closing the browser, whereas the server session is maintained at the server end.

## Example

Create a user session when the user logs in and invalidate the session when the user logs out.

Steps:
1. `login.jsp` to grab username and password of user.
2. `checkLoginDetails.jsp` which will check the username and password are correct. If they are correct it will store the username in session and redirect to `success.jsp`.
3. `success.jsp` will print the username of the user stored in the session.
4. `logout.jsp` will call session.invalidate() to kill the server session.
    1. This means that trying to access session object after [`invalidate()`](https://tomcat.apache.org/tomcat-9.0-doc/servletapi/javax/servlet/http/HttpSession.html#invalidate--) which will throw an error.

### Files

1. `login.jsp`
```jsp
<!DOCTYPE html>
<html>
   <head>
      <title>Login Form</title>
   </head>
   <body>
      <form action="displayLoginDetails.jsp" method="POST">
         Username: <input type="text" name="username"/> <br/>
         Password:<input type="password" name="password"/> <br/>
         <input type="submit" value="Submit"/>
      </form>
   </body>
</html>
```

2. `checkLoginDetails.jsp`
```jsp
<%@ page import="java.sql.*" %>
<%
   try {
      String userid = request.getParameter("username");
      String pwd    = request.getParameter("password");
   	Class.forName("com.mysql.jdbc.Driver");
   	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbname", "root", "dbpass");
   	Statement  st  = con.createStatement();
   	ResultSet  rs;
   	rs = st.executeQuery("SELECT * FROM users WHERE username='" + userid + "' AND password='" + pwd + "'");
   	if (rs.next()) {
   		session.setAttribute("user", userid); // The username will be stored in the session
   		out.println("welcome " + userid);
   		out.println("<a href='logout.jsp'>Log out</a>");
   		response.sendRedirect("success.jsp");
   	}
   	else {
   		out.println("Invalid password <a href='login.jsp'>try again</a>");
   	}
   }
   catch (ClassNotFoundException | SQLException e) {
   	e.printStackTrace();
   }
%>
```
3. `success.jsp`
```jsp
<%
    if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
Welcome <%=session.getAttribute("user")%>  // This will display the username that is stored in the session.
<a href='logout.jsp'>Log out</a>
<%
    }
%>
```
4. `logout.jsp`
```jsp
<%
session.invalidate();
session.getAttribute("user"); // This will throw an error
response.sendRedirect("login.jsp");
%>
```
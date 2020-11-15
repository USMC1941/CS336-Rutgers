package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ApplicationDB {

   public ApplicationDB() {

   }

   public static void main(String[] args) {
      ApplicationDB applicationDB = new ApplicationDB();
      Connection    connection    = applicationDB.getConnection();

      System.out.println(connection);
      applicationDB.closeConnection(connection);
   }

   public Connection getConnection() {
      String     connectionURL = "jdbc:mysql://localhost:3306/barbeerdrinkersample";
      Connection connection    = null;

      try {
         Class.forName("com.mysql.cj.jdbc.Driver");

         // Create a connection to your DB. "dbUsername" and "dbPassword" are the databases' username and password respectively.
         connection = DriverManager.getConnection(connectionURL, "dbUsername", "dbPassword");
      }
      catch (ClassNotFoundException | SQLException e) {
         e.printStackTrace();
      }
      return connection;
   }

   public void closeConnection(Connection connection) {
      try {
         connection.close();
      }
      catch (SQLException e) {
         e.printStackTrace();
      }
   }
}

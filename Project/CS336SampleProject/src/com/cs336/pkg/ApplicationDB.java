package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ApplicationDB {

	public ApplicationDB() {

	}

	public Connection getConnection() {
		// To use the SQL file, first import it into MySQL Workbench

		// JDBC Connection String
		String     connectionUrl = "jdbc:mysql://localhost:3306/barbeerdrinkersample";
		Connection connection    = null;
		//
		try {
			// JDBC driver for MySQL. Located in WEB-INF/lib. Latest: https://dev.mysql.com/downloads/connector/j/
			Class.forName("com.mysql.cj.jdbc.Driver");
			// Create a connection to your DB. "dbUsername" and "dbPassword" are the databases' username and password respectively.
			connection = DriverManager.getConnection(connectionUrl, "dbUsername", "dbPassword");
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


	/**
	 * @param args Arguments. Make sure to add the MySql .jar in WebContent/WEB-INF/lib
	 */
	public static void main(String[] args) {
		ApplicationDB dao        = new ApplicationDB();
		Connection    connection = dao.getConnection();

		System.out.println(connection);
		dao.closeConnection(connection);
	}
}

package com.example.jdbcjspservlate;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database Connection Utility
 * Manages MySQL database connections for CRUD operations
 */
public class DBConnection {

    static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String URL    = "jdbc:mysql://localhost:3306/studentdb";
    static final String USER   = "root";
    static final String PASS   = "abhrabca";

    /**
     * Gets a connection to the database
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(DRIVER);
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
    }

    /**
     * Test the connection
     */
    public static void main(String[] args) {
        try {
            Connection con = getConnection();
            System.out.println("✅ Connection Successful!");
            con.close();
        } catch (SQLException e) {
            System.out.println("❌ Connection Failed: " + e.getMessage());
        }
    }
}


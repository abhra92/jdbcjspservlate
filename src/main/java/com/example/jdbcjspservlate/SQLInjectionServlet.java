package com.example.jdbcjspservlate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * SQL Injection Prevention Demo Servlet
 * Demonstrates vulnerable vs. secure database access patterns via web UI
 */
@WebServlet(name = "SQLInjectionServlet", value = "/sql-injection")
public class SQLInjectionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("sql-injection.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String method = request.getParameter("method");

        String sqlQuery;
        String result;
        String user = null;

        if ("vulnerable".equals(method)) {
            // Vulnerable: string concatenation (Statement)
            sqlQuery = "SELECT * FROM users WHERE username = '"
                    + username + "' AND password = '" + password + "'";

            try (Connection con = DBConnection.getConnection();
                 Statement st = con.createStatement();
                 ResultSet rs = st.executeQuery(sqlQuery)) {

                if (rs.next()) {
                    result = "success";
                    user = rs.getString("username");
                } else {
                    result = "failed";
                }

            } catch (SQLException e) {
                result = "failed";
                sqlQuery = sqlQuery + " [Error: " + e.getMessage() + "]";
            }

        } else {
            // Safe: parameterized query (PreparedStatement)
            sqlQuery = "SELECT * FROM users WHERE username = ? AND password = ?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sqlQuery)) {

                ps.setString(1, username);
                ps.setString(2, password);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        result = "success";
                        user = rs.getString("username");
                    } else {
                        result = "failed";
                    }
                }

            } catch (SQLException e) {
                result = "failed";
            }
        }

        request.setAttribute("sqlQuery", sqlQuery);
        request.setAttribute("result", result);
        request.setAttribute("method", method);
        request.setAttribute("username", username);
        request.setAttribute("password", password);
        request.setAttribute("user", user);

        request.getRequestDispatcher("sql-injection.jsp").forward(request, response);
    }
}

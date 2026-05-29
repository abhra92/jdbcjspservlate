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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Transaction Management Demo Servlet
 * Demonstrates ACID properties with Commit and Rollback via web UI
 */
@WebServlet(name = "TransactionServlet", value = "/transaction")
public class TransactionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("accounts", getAccounts());
        request.getRequestDispatcher("transaction.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int fromAcc = Integer.parseInt(request.getParameter("fromAcc"));
        int toAcc = Integer.parseInt(request.getParameter("toAcc"));
        double amount = Double.parseDouble(request.getParameter("amount"));

        String transferResult;
        String transferMessage;

        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // Debit from sender
            String debitSQL = "UPDATE accounts SET balance = balance - ? WHERE acc_id = ?";
            PreparedStatement debitPS = con.prepareStatement(debitSQL);
            debitPS.setDouble(1, amount);
            debitPS.setInt(2, fromAcc);
            debitPS.executeUpdate();

            // Check for sufficient balance
            String balSQL = "SELECT balance FROM accounts WHERE acc_id = ?";
            PreparedStatement balPS = con.prepareStatement(balSQL);
            balPS.setInt(1, fromAcc);
            ResultSet rs = balPS.executeQuery();
            rs.next();
            double newBalance = rs.getDouble("balance");

            if (newBalance < 0) {
                throw new Exception("Insufficient balance in Account #" + fromAcc);
            }

            // Credit to receiver
            String creditSQL = "UPDATE accounts SET balance = balance + ? WHERE acc_id = ?";
            PreparedStatement creditPS = con.prepareStatement(creditSQL);
            creditPS.setDouble(1, amount);
            creditPS.setInt(2, toAcc);
            creditPS.executeUpdate();

            // Commit
            con.commit();
            transferResult = "committed";
            transferMessage = "Transfer of " + amount + " from Account #" + fromAcc
                    + " to Account #" + toAcc + " completed successfully.";

        } catch (Exception e) {
            transferResult = "rolled_back";
            transferMessage = "Transfer failed: " + e.getMessage() + ". All changes have been rolled back.";

            try {
                if (con != null) {
                    con.rollback();
                }
            } catch (SQLException rollbackEx) {
                transferMessage += " (Rollback error: " + rollbackEx.getMessage() + ")";
            }

        } finally {
            try {
                if (con != null) {
                    con.setAutoCommit(true);
                    con.close();
                }
            } catch (SQLException e) {
                // ignore close error
            }
        }

        request.setAttribute("transferResult", transferResult);
        request.setAttribute("transferMessage", transferMessage);
        request.setAttribute("fromAcc", String.valueOf(fromAcc));
        request.setAttribute("toAcc", String.valueOf(toAcc));
        request.setAttribute("amount", String.valueOf(amount));
        request.setAttribute("accounts", getAccounts());

        request.getRequestDispatcher("transaction.jsp").forward(request, response);
    }

    /**
     * Reads all account balances from the accounts table
     */
    private List<Map<String, Object>> getAccounts() {
        List<Map<String, Object>> accounts = new ArrayList<>();
        String sql = "SELECT * FROM accounts ORDER BY acc_id";

        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Map<String, Object> account = new HashMap<>();
                account.put("accId", rs.getInt("acc_id"));
                account.put("name", rs.getString("name"));
                account.put("balance", rs.getDouble("balance"));
                accounts.add(account);
            }

        } catch (SQLException e) {
            // Return empty list on error
        }

        return accounts;
    }
}

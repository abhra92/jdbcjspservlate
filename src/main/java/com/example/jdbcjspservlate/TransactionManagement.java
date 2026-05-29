package com.example.jdbcjspservlate;

import java.sql.*;

/**
 * Transaction Management Demo
 * Demonstrates ACID properties with Commit and Rollback
 *
 * Scenario: Bank Transfer between two accounts
 * Both operations (debit + credit) must succeed or both must fail
 */
public class TransactionManagement {

    /**
     * Java 8 compatible string repeat utility
     */
    public static String repeat(String str, int count) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < count; i++) {
            sb.append(str);
        }
        return sb.toString();
    }

    /**
     * Transfer money between accounts with transaction management
     *
     * ACID Properties:
     * • Atomicity: All operations succeed or all fail
     * • Consistency: Database state remains valid
     * • Isolation: Concurrent transactions don't interfere
     * • Durability: Committed data survives failures
     */
    public static void transferMoney(int fromAcc, int toAcc, double amount) {

        Connection con = null;

        try {
            con = DBConnection.getConnection();

            // ── STEP 1: Disable Auto-Commit ──────────────────────────────
            con.setAutoCommit(false);   // Manual transaction control
            System.out.println("🔄 Transaction Started...");

            // ── STEP 2: Debit from sender ────────────────────────────────
            String debitSQL = "UPDATE accounts SET balance = balance - ? WHERE acc_id = ?";
            PreparedStatement debitPS = con.prepareStatement(debitSQL);
            debitPS.setDouble(1, amount);
            debitPS.setInt(2, fromAcc);
            int debitRows = debitPS.executeUpdate();
            System.out.println("💸 Debited ₹" + amount + " from Account " + fromAcc);

            // ── STEP 3: Check for sufficient balance ─────────────────────
            String balSQL = "SELECT balance FROM accounts WHERE acc_id = ?";
            PreparedStatement balPS = con.prepareStatement(balSQL);
            balPS.setInt(1, fromAcc);
            ResultSet rs = balPS.executeQuery();
            rs.next();
            double newBalance = rs.getDouble("balance");

            if (newBalance < 0) {
                // ❌ Insufficient funds — trigger rollback
                throw new Exception("⛔ Insufficient Balance! Transaction Aborted.");
            }

            // Simulate processing delay (optional)
            Thread.sleep(500);

            // ── STEP 4: Credit to receiver ───────────────────────────────
            String creditSQL = "UPDATE accounts SET balance = balance + ? WHERE acc_id = ?";
            PreparedStatement creditPS = con.prepareStatement(creditSQL);
            creditPS.setDouble(1, amount);
            creditPS.setInt(2, toAcc);
            int creditRows = creditPS.executeUpdate();
            System.out.println("💰 Credited ₹" + amount + " to Account " + toAcc);

            // ── STEP 5: COMMIT — All operations succeeded ─────────────────
            con.commit();
            System.out.println("\n✅ TRANSACTION COMMITTED SUCCESSFULLY!");
            System.out.println("   Transfer of ₹" + amount
                             + " from Acc#" + fromAcc
                             + " to Acc#" + toAcc + " complete.");

        } catch (Exception e) {

            // ── STEP 6: ROLLBACK — Undo all changes on failure ────────────
            System.out.println("\n❌ ERROR: " + e.getMessage());
            System.out.println("🔁 Rolling back transaction...");

            try {
                if (con != null) {
                    con.rollback();   // Revert all changes
                    System.out.println("⚠️  TRANSACTION ROLLED BACK — No changes saved.");
                }
            } catch (SQLException rollbackEx) {
                System.out.println("Rollback Error: " + rollbackEx.getMessage());
            }

        } finally {

            // ── STEP 7: Restore Auto-Commit & Close Connection ────────────
            try {
                if (con != null) {
                    con.setAutoCommit(true);   // Restore default behavior
                    con.close();
                    System.out.println("🔒 Connection closed.");
                }
            } catch (SQLException e) {
                System.out.println("Close Error: " + e.getMessage());
            }
        }
    }

    /**
     * Display account balances in formatted table
     */
    public static void showBalances() {
        String sql = "SELECT * FROM accounts ORDER BY acc_id";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            System.out.println("\n" + repeat("─", 45));
            System.out.printf("%-12s %-15s %-15s%n", "ACC_ID", "NAME", "BALANCE");
            System.out.println(repeat("─", 45));

            while (rs.next()) {
                System.out.printf("%-12d %-15s ₹%-15.2f%n",
                    rs.getInt("acc_id"),
                    rs.getString("name"),
                    rs.getDouble("balance"));
            }
            System.out.println(repeat("─", 45) + "\n");

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    /**
     * Display transaction rules and best practices
     */
    public static void displayTransactionInfo() {
        System.out.println("\n" + repeat("=", 80));
        System.out.println("🏦 TRANSACTION MANAGEMENT - BANK TRANSFER SCENARIO");
        System.out.println(repeat("=", 80));

        System.out.println("📋 SCENARIO: Bank Transfer between two accounts\n" +
                "   Debit ₹X from Account A  →  Credit ₹X to Account B\n" +
                "\n" +
                "🔒 ACID PROPERTIES:\n" +
                "   • Atomicity:     All operations succeed or none succeed\n" +
                "   • Consistency:   DB state remains valid before & after\n" +
                "   • Isolation:     Concurrent transactions don't interfere\n" +
                "   • Durability:    Committed data survives system failures\n" +
                "\n" +
                "⚙️  TRANSACTION FLOW:\n" +
                "   1. setAutoCommit(false)    → Start manual transaction\n" +
                "   2. Run: UPDATE (debit)     → Subtract from account A\n" +
                "   3. Check: SELECT balance   → Verify sufficient funds\n" +
                "   4. Run: UPDATE (credit)    → Add to account B\n" +
                "   5. commit() or rollback()  → Save or undo all changes\n" +
                "\n" +
                "❌ FAILURE SCENARIOS:\n" +
                "   • Network disconnect      → Automatic rollback\n" +
                "   • Insufficient balance    → Manual rollback\n" +
                "   • Database error          → Automatic rollback\n" +
                "   • Business logic error    → Manual rollback");

        System.out.println(repeat("=", 80) + "\n");
    }

    /**
     * Main demonstration
     */
    public static void main(String[] args) {

        displayTransactionInfo();

        System.out.println("📊 Initial Account Balances:");
        showBalances();

        // ✅ Test Case 1: Valid Transfer (should COMMIT)
        System.out.println("════════════════════════════════════════════════════════════════");
        System.out.println("✅ TEST 1: Valid Transfer (Sufficient Funds)");
        System.out.println("════════════════════════════════════════════════════════════════");
        transferMoney(1, 2, 3000);

        System.out.println("\n📊 Balances After Successful Transfer:");
        showBalances();

        // ❌ Test Case 2: Insufficient Funds (should ROLLBACK)
        System.out.println("════════════════════════════════════════════════════════════════");
        System.out.println("❌ TEST 2: Failed Transfer (Insufficient Funds)");
        System.out.println("════════════════════════════════════════════════════════════════");
        transferMoney(1, 2, 50000);

        System.out.println("\n📊 Balances After Failed Transfer (Unchanged - Rolled Back):");
        showBalances();

        // ✅ Test Case 3: Another Valid Transfer
        System.out.println("════════════════════════════════════════════════════════════════");
        System.out.println("✅ TEST 3: Another Valid Transfer");
        System.out.println("════════════════════════════════════════════════════════════════");
        transferMoney(3, 1, 1500);

        System.out.println("\n📊 Balances After Second Successful Transfer:");
        showBalances();

        // Display Summary
        System.out.println("\n" + repeat("=", 80));
        System.out.println("📌 KEY TAKEAWAYS");
        System.out.println(repeat("=", 80));
        System.out.println("✅ Benefits of Transaction Management:\n" +
                "   • Data Consistency: Ensures database state is always valid\n" +
                "   • Atomicity: Related operations succeed as a unit\n" +
                "   • Error Recovery: Automatic undo on failure\n" +
                "   • Reliability: Prevents partial/incomplete updates\n" +
                "   • Business Logic: Enforces complex business rules\n" +
                "\n" +
                "✅ Best Practices:\n" +
                "   1. Set autoCommit(false) for transactions\n" +
                "   2. Validate conditions before operations\n" +
                "   3. Use try-catch-finally for reliable cleanup\n" +
                "   4. Rollback on any validation failure\n" +
                "   5. Always close connections (use try-with-resources)\n" +
                "   6. Keep transactions as SHORT as possible\n" +
                "   7. Avoid nested transactions if possible\n" +
                "\n" +
                "💡 When to Use Transactions:\n" +
                "   • Bank transfers (money must move atomically)\n" +
                "   • Inventory management (stock must be consistent)\n" +
                "   • Order processing (order + payment together)\n" +
                "   • Data migrations (all or nothing)");
        System.out.println(repeat("=", 80) + "\n");
    }
}




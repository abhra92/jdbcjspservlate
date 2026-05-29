package com.example.jdbcjspservlate;

import java.sql.*;

/**
 * SQL Injection Prevention Demo
 * Demonstrates vulnerable vs. secure database access patterns
 *
 * ⚠️ WARNING: The vulnerable code is for EDUCATIONAL PURPOSES ONLY
 * NEVER USE vulnerable code in production!
 */
public class PreventSQLInjection {

    /**
     * ❌ VULNERABLE METHOD — Using Statement (BAD PRACTICE)
     * ⚠️ DO NOT USE IN PRODUCTION
     *
     * If user enters: ' OR '1'='1  → query always returns true!
     * If user enters: ' OR '1'='1' --  → bypasses password check
     */
    public static void vulnerableLogin(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = '"
                   + username + "' AND password = '" + password + "'";

        System.out.println("\n🔴 VULNERABLE SQL: " + sql);

        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            if (rs.next()) {
                System.out.println("⚠️  LOGIN SUCCESS (Vulnerable!) — User: "
                                 + rs.getString("username"));
            } else {
                System.out.println("❌ LOGIN FAILED.");
            }

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    /**
     * ✅ SAFE METHOD — Using PreparedStatement (GOOD PRACTICE)
     *
     * '?' acts as a placeholder — input is treated as DATA, not SQL code
     * The database driver automatically escapes special characters
     */
    public static void safeLogin(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        System.out.println("🟢 SAFE SQL (Parameterized): " + sql);

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);  // Binds username safely
            ps.setString(2, password);  // Binds password safely

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                System.out.println("✅ LOGIN SUCCESS (Safe!) — User: "
                                 + rs.getString("username"));
            } else {
                System.out.println("❌ LOGIN FAILED — Invalid credentials.");
            }

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    /**
     * ✅ SAFE METHOD with Comment Injection Test
     */
    public static void safeSearchStudent(String name) {
        String sql = "SELECT * FROM students WHERE name LIKE ?";

        System.out.println("🟢 SAFE SEARCH: " + sql);

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + name + "%");

            ResultSet rs = ps.executeQuery();
            boolean found = false;

            while (rs.next()) {
                System.out.printf("   Found: %d - %s (Age: %d, Email: %s)\n",
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getInt("age"),
                    rs.getString("email"));
                found = true;
            }

            if (!found) {
                System.out.println("   No students found with that name.");
            }

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    /**
     * Display comparison table
     */
    public static String repeat(String str, int count) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < count; i++) {
            sb.append(str);
        }
        return sb.toString();
    }

    public static void displayComparisonTable() {
        System.out.println("\n" + repeat("=", 80));
        System.out.println("🛡️  SQL INJECTION PREVENTION COMPARISON");
        System.out.println(repeat("=", 80));

        System.out.println(String.format("%-25s | %-20s | %-20s",
            "Feature", "Statement", "PreparedStatement"));
        System.out.println(repeat("-", 80));

        System.out.println(String.format("%-25s | %-20s | %-20s",
            "Query Type", "Dynamic string", "Pre-compiled template"));
        System.out.println(String.format("%-25s | %-20s | %-20s",
            "Input Handling", "Concatenated as SQL", "Treated as DATA"));
        System.out.println(String.format("%-25s | %-20s | %-20s",
            "SQL Injection Risk", "❌ HIGH", "✅ NONE"));
        System.out.println(String.format("%-25s | %-20s | %-20s",
            "Performance", "Slower", "Faster"));
        System.out.println(String.format("%-25s | %-20s | %-20s",
            "Readability", "Poor", "Clean"));
        System.out.println(String.format("%-25s | %-20s | %-20s",
            "Recommended", "❌ NO", "✅ YES"));

        System.out.println(repeat("=", 80) + "\n");
    }

    /**
     * Main demonstration
     */
    public static void main(String[] args) {

        displayComparisonTable();

        // Test Case 1: Normal Login
        System.out.println("════════════════════════════════════════════════════════════════");
        System.out.println("📌 TEST 1: Normal Login");
        System.out.println("════════════════════════════════════════════════════════════════");

        System.out.println("\n👤 User Input: alice / pass123");
        vulnerableLogin("alice", "pass123");
        safeLogin("alice", "pass123");

        // Test Case 2: SQL Injection Attempt 1
        System.out.println("\n\n════════════════════════════════════════════════════════════════");
        System.out.println("📌 TEST 2: SQL Injection Attempt - Comment Injection");
        System.out.println("════════════════════════════════════════════════════════════════");

        String injectedUser1 = "' OR '1'='1";
        String injectedPass1 = " ";

        System.out.println("\n⚠️  INJECTION PAYLOAD: ' OR '1'='1");
        System.out.println("💭 Intent: Bypass authentication by making condition always true");
        vulnerableLogin(injectedUser1, injectedPass1);
        safeLogin(injectedUser1, injectedPass1);

        // Test Case 3: SQL Injection Attempt 2
        System.out.println("\n\n════════════════════════════════════════════════════════════════");
        System.out.println("📌 TEST 3: SQL Injection Attempt - Comment Attack");
        System.out.println("════════════════════════════════════════════════════════════════");

        String injectedUser2 = "alice' --";
        String injectedPass2 = "";

        System.out.println("\n⚠️  INJECTION PAYLOAD: alice' --");
        System.out.println("💭 Intent: Comment out password check");
        vulnerableLogin(injectedUser2, injectedPass2);
        safeLogin(injectedUser2, injectedPass2);

        // Test Case 4: Safe Search Operation
        System.out.println("\n\n════════════════════════════════════════════════════════════════");
        System.out.println("📌 TEST 4: Safe Search - Normal Input");
        System.out.println("════════════════════════════════════════════════════════════════");

        System.out.println("\n🔍 Search for students with name containing 'a':");
        safeSearchStudent("a");

        // Test Case 5: Safe Search with Special Characters
        System.out.println("\n\n════════════════════════════════════════════════════════════════");
        System.out.println("📌 TEST 5: Safe Search - Special Characters (Safety Test)");
        System.out.println("════════════════════════════════════════════════════════════════");

        System.out.println("\n🔍 Search with special characters: %' OR '1'='1");
        safeSearchStudent("%' OR '1'='1");

        // Summary
        System.out.println("\n\n" + repeat("=", 80));
        System.out.println("📌 KEY TAKEAWAYS");
        System.out.println(repeat("=", 80));
        System.out.println("✅ ALWAYS use PreparedStatement for database queries\n" +
                "✅ Use '?' placeholders for user inputs\n" +
                "✅ Let the database driver handle input escaping\n" +
                "❌ NEVER concatenate strings into SQL queries\n" +
                "❌ NEVER trust user input\n" +
                "❌ NEVER use Statement with dynamic SQL\n" +
                "\n" +
                "🛡️  PreparedStatement prevents SQL injection by:\n" +
                "   1. Pre-compiling the query template\n" +
                "   2. Treating input as data, not SQL code\n" +
                "   3. Automatically escaping special characters\n" +
                "   4. Separating code structure from user data");
        System.out.println(repeat("=", 80) + "\n");
    }
}



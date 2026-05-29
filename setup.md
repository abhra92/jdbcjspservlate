# SECTION D: JDBC + JSP/SERVLET

---

## 1. CRUD Operations Using JDBC

> **Prerequisites:** MySQL table setup
```sql
CREATE DATABASE studentdb;
USE studentdb;
CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    email VARCHAR(100)
);
```

```java
import java.sql.*;
import java.util.Scanner;

public class CRUDOperations {

    // ─── DB CONNECTION DETAILS ───────────────────────────────────────────────
    static final String URL    = "jdbc:mysql://localhost:3306/studentdb";
    static final String USER   = "root";
    static final String PASS   = "abhrabca";

    // ─── GET CONNECTION ──────────────────────────────────────────────────────
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    // ════════════════════════════════════════════════════════════════════════
    // 1️⃣  CREATE — Insert a new student
    // ════════════════════════════════════════════════════════════════════════
    public static void insertStudent(String name, int age, String email) {
        String sql = "INSERT INTO students (name, age, email) VALUES (?, ?, ?)";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setInt   (2, age);
            ps.setString(3, email);

            int rows = ps.executeUpdate();
            System.out.println("✅ INSERT SUCCESS — Rows affected: " + rows);

        } catch (SQLException e) {
            System.out.println("❌ INSERT FAILED: " + e.getMessage());
        }
    }

    // ════════════════════════════════════════════════════════════════════════
    // 2️⃣  READ — Fetch all students
    // ════════════════════════════════════════════════════════════════════════
    public static void readStudents() {
        String sql = "SELECT * FROM students";

        try (Connection con = getConnection();
             Statement  st  = con.createStatement();
             ResultSet  rs  = st.executeQuery(sql)) {

            System.out.println("\n─────────────────────────────────────────");
            System.out.printf("%-5s %-20s %-5s %-25s%n",
                              "ID", "NAME", "AGE", "EMAIL");
            System.out.println("─────────────────────────────────────────");

            while (rs.next()) {
                System.out.printf("%-5d %-20s %-5d %-25s%n",
                    rs.getInt   ("id"),
                    rs.getString("name"),
                    rs.getInt   ("age"),
                    rs.getString("email"));
            }
            System.out.println("─────────────────────────────────────────\n");

        } catch (SQLException e) {
            System.out.println("❌ READ FAILED: " + e.getMessage());
        }
    }

    // ════════════════════════════════════════════════════════════════════════
    // 3️⃣  UPDATE — Update student email by ID
    // ════════════════════════════════════════════════════════════════════════
    public static void updateStudent(int id, String newEmail) {
        String sql = "UPDATE students SET email = ? WHERE id = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, newEmail);
            ps.setInt   (2, id);

            int rows = ps.executeUpdate();
            if (rows > 0)
                System.out.println("✅ UPDATE SUCCESS — Student ID " + id + " updated.");
            else
                System.out.println("⚠️  No record found with ID: " + id);

        } catch (SQLException e) {
            System.out.println("❌ UPDATE FAILED: " + e.getMessage());
        }
    }

    // ════════════════════════════════════════════════════════════════════════
    // 4️⃣  DELETE — Delete student by ID
    // ════════════════════════════════════════════════════════════════════════
    public static void deleteStudent(int id) {
        String sql = "DELETE FROM students WHERE id = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            int rows = ps.executeUpdate();
            if (rows > 0)
                System.out.println("✅ DELETE SUCCESS — Student ID " + id + " removed.");
            else
                System.out.println("⚠️  No record found with ID: " + id);

        } catch (SQLException e) {
            System.out.println("❌ DELETE FAILED: " + e.getMessage());
        }
    }

    // ════════════════════════════════════════════════════════════════════════
    // MAIN METHOD
    // ════════════════════════════════════════════════════════════════════════
    public static void main(String[] args) {

        // CREATE
        insertStudent("Abhra",  22, "abhra@example.com");
        insertStudent("Bca",    25, "bca@example.com");
        insertStudent("Claude",21, "claude@example.com");

        // READ
        System.out.println("📋 All Students:");
        readStudents();

        // UPDATE
        updateStudent(1, "alice_new@example.com");

        // READ after update
        System.out.println("📋 After Update:");
        readStudents();

        // DELETE
        deleteStudent(3);

        // READ after delete
        System.out.println("📋 After Delete:");
        readStudents();
    }
}
```

### 📤 Sample Output
```
✅ INSERT SUCCESS — Rows affected: 1
✅ INSERT SUCCESS — Rows affected: 1
✅ INSERT SUCCESS — Rows affected: 1

📋 All Students:
─────────────────────────────────────────
ID    NAME                 AGE   EMAIL
─────────────────────────────────────────
1     Alice                22    alice@example.com
2     Bob                  25    bob@example.com
3     Charlie              21    charlie@example.com
─────────────────────────────────────────

✅ UPDATE SUCCESS — Student ID 1 updated.
✅ DELETE SUCCESS — Student ID 3 removed.
```

---

## 2. PreparedStatement to Prevent SQL Injection

> **Concept:** SQL Injection occurs when malicious SQL code is inserted through user inputs. `PreparedStatement` uses **parameterized queries** to neutralize this.

```java
import java.sql.*;
import java.util.Scanner;

public class PreventSQLInjection {

    static final String URL  = "jdbc:mysql://localhost:3306/studentdb";
    static final String USER = "root";
    static final String PASS = "abhrabca";

    // ════════════════════════════════════════════════════════════════════════
    // ❌ VULNERABLE METHOD — Using Statement (BAD PRACTICE)
    // ════════════════════════════════════════════════════════════════════════
    public static void vulnerableLogin(String username, String password) {
        // ⚠️ If user enters: ' OR '1'='1  → query always returns true!
        String sql = "SELECT * FROM users WHERE username = '" 
                   + username + "' AND password = '" + password + "'";

        System.out.println("🔴 Vulnerable SQL: " + sql);

        try (Connection con = DriverManager.getConnection(URL, USER, PASS);
             Statement  st  = con.createStatement();
             ResultSet  rs  = st.executeQuery(sql)) {

            if (rs.next())
                System.out.println("⚠️  LOGIN SUCCESS (Vulnerable!) — User: "
                                   + rs.getString("username"));
            else
                System.out.println("LOGIN FAILED.");

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    // ════════════════════════════════════════════════════════════════════════
    // ✅ SAFE METHOD — Using PreparedStatement (GOOD PRACTICE)
    // ════════════════════════════════════════════════════════════════════════
    public static void safeLogin(String username, String password) {
        // ✅ '?' acts as a placeholder — input is treated as DATA, not SQL code
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        System.out.println("🟢 Safe SQL (Parameterized): " + sql);

        try (Connection con = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);  // Binds username safely
            ps.setString(2, password);  // Binds password safely

            ResultSet rs = ps.executeQuery();

            if (rs.next())
                System.out.println("✅ LOGIN SUCCESS (Safe!) — User: "
                                   + rs.getString("username"));
            else
                System.out.println("❌ LOGIN FAILED — Invalid credentials.");

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    // ════════════════════════════════════════════════════════════════════════
    // MAIN METHOD
    // ════════════════════════════════════════════════════════════════════════
    public static void main(String[] args) {

        System.out.println("========= NORMAL LOGIN =========");
        vulnerableLogin("alice", "pass123");
        safeLogin      ("alice", "pass123");

        System.out.println("\n===== SQL INJECTION ATTEMPT =====");
        // Classic injection: ' OR '1'='1
        String injectedUser = "' OR '1'='1";
        String injectedPass = "' OR '1'='1";

        System.out.println("⚠️  Attempting SQL Injection...");
        vulnerableLogin(injectedUser, injectedPass);  // ❌ May bypass login!
        safeLogin      (injectedUser, injectedPass);  // ✅ Injection neutralized!
    }
}
```

### 📤 Sample Output
```
========= NORMAL LOGIN =========
🔴 Vulnerable SQL: SELECT * FROM users WHERE username = 'alice' AND password = 'pass123'
⚠️  LOGIN SUCCESS (Vulnerable!) — User: alice
🟢 Safe SQL (Parameterized): SELECT * FROM users WHERE username = ? AND password = ?
✅ LOGIN SUCCESS (Safe!) — User: alice

===== SQL INJECTION ATTEMPT =====
⚠️  Attempting SQL Injection...
🔴 Vulnerable SQL: SELECT * FROM users WHERE username = '' OR '1'='1' AND password = '' OR '1'='1'
⚠️  LOGIN SUCCESS (Vulnerable!) — User: alice   ← BYPASSED!
🟢 Safe SQL (Parameterized): SELECT * FROM users WHERE username = ? AND password = ?
❌ LOGIN FAILED — Invalid credentials.           ← INJECTION BLOCKED ✅
```

### 🛡️ Why PreparedStatement Prevents SQL Injection

| Feature | `Statement` | `PreparedStatement` |
|---|---|---|
| Query type | Dynamic string | Pre-compiled template |
| User input handling | Concatenated as SQL | Treated as **literal data** |
| SQL Injection risk | ❌ **HIGH** | ✅ **NONE** |
| Performance | Slower (re-compiled) | Faster (pre-compiled) |
| Readability | Poor | Clean |

---

## 3. Transaction Management (Commit & Rollback)

> **Concept:** A transaction groups multiple SQL operations into one atomic unit. Either **ALL succeed (COMMIT)** or **ALL fail (ROLLBACK)** — ensuring data consistency (ACID properties).

```java
import java.sql.*;

public class TransactionManagement {

    static final String URL  = "jdbc:mysql://localhost:3306/studentdb";
    static final String USER = "root";
    static final String PASS = "abhrabca";

    /*
     *  Scenario: Bank Transfer
     *  Debit ₹5000 from Account A  →  Credit ₹5000 to Account B
     *  Both must succeed or both must be rolled back.
     *
     *  SQL Setup:
     *  CREATE TABLE accounts (
     *      acc_id   INT PRIMARY KEY,
     *      name     VARCHAR(50),
     *      balance  DOUBLE
     *  );
     *  INSERT INTO accounts VALUES (1, 'Alice', 10000);
     *  INSERT INTO accounts VALUES (2, 'Bob',    5000);
     */

    public static void transferMoney(int fromAcc, int toAcc, double amount) {

        Connection con = null;

        try {
            con = DriverManager.getConnection(URL, USER, PASS);

            // ── STEP 1: Disable Auto-Commit ──────────────────────────────
            con.setAutoCommit(false);   // ⚡ Start transaction manually
            System.out.println("🔄 Transaction Started...");

            // ── STEP 2: Debit from sender ────────────────────────────────
            String debitSQL  = "UPDATE accounts SET balance = balance - ? WHERE acc_id = ?";
            PreparedStatement debitPS = con.prepareStatement(debitSQL);
            debitPS.setDouble(1, amount);
            debitPS.setInt   (2, fromAcc);
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

            // ── STEP 4: Credit to receiver ───────────────────────────────
            String creditSQL = "UPDATE accounts SET balance = balance + ? WHERE acc_id = ?";
            PreparedStatement creditPS = con.prepareStatement(creditSQL);
            creditPS.setDouble(1, amount);
            creditPS.setInt   (2, toAcc);
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
                    con.rollback();   // ↩️ Revert all changes
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

    // ────────────────────────────────────────────────────────────────────────
    // Display account balances
    // ────────────────────────────────────────────────────────────────────────
    public static void showBalances() {
        String sql = "SELECT * FROM accounts";
        try (Connection con = DriverManager.getConnection(URL, USER, PASS);
             Statement  st  = con.createStatement();
             ResultSet  rs  = st.executeQuery(sql)) {

            System.out.println("\n─────────────────────────────────");
            System.out.printf("%-10s %-15s %-10s%n", "ACC_ID", "NAME", "BALANCE");
            System.out.println("─────────────────────────────────");
            while (rs.next()) {
                System.out.printf("%-10d %-15s ₹%-10.2f%n",
                    rs.getInt   ("acc_id"),
                    rs.getString("name"),
                    rs.getDouble("balance"));
            }
            System.out.println("─────────────────────────────────\n");

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    // ════════════════════════════════════════════════════════════════════════
    // MAIN METHOD
    // ════════════════════════════════════════════════════════════════════════
    public static void main(String[] args) {

        System.out.println("📊 Initial Balances:");
        showBalances();

        // ✅ Test Case 1: Valid Transfer (should COMMIT)
        System.out.println("════════ TEST 1: Valid Transfer ════════");
        transferMoney(1, 2, 3000);   // Alice → Bob: ₹3000

        System.out.println("\n📊 Balances After Successful Transfer:");
        showBalances();

        // ❌ Test Case 2: Insufficient Funds (should ROLLBACK)
        System.out.println("════════ TEST 2: Insufficient Funds ════");
        transferMoney(1, 2, 50000);  // Alice tries to send ₹50,000 (not enough)

        System.out.println("\n📊 Balances After Failed Transfer (Unchanged):");
        showBalances();
    }
}
```

### 📤 Sample Output
```
📊 Initial Balances:
─────────────────────────────────
ACC_ID     NAME            BALANCE
─────────────────────────────────
1          Alice           ₹10000.00
2          Bob             ₹5000.00
─────────────────────────────────

════════ TEST 1: Valid Transfer ════════
🔄 Transaction Started...
💸 Debited ₹3000.0 from Account 1
💰 Credited ₹3000.0 to Account 2
✅ TRANSACTION COMMITTED SUCCESSFULLY!
   Transfer of ₹3000.0 from Acc#1 to Acc#2 complete.

📊 Balances After Successful Transfer:
─────────────────────────────────
1   Alice   ₹7000.00
2   Bob     ₹8000.00
─────────────────────────────────

════════ TEST 2: Insufficient Funds ════
🔄 Transaction Started...
💸 Debited ₹50000.0 from Account 1
❌ ERROR: ⛔ Insufficient Balance! Transaction Aborted.
🔁 Rolling back transaction...
⚠️  TRANSACTION ROLLED BACK — No changes saved.
🔒 Connection closed.

📊 Balances After Failed Transfer (Unchanged):
─────────────────────────────────
1   Alice   ₹7000.00    ← Unchanged ✅
2   Bob     ₹8000.00    ← Unchanged ✅
─────────────────────────────────
```

---

## 📌 Key Concepts Summary

| Concept | Description |
|---|---|
| `DriverManager.getConnection()` | Establishes DB connection |
| `Statement` | Executes static SQL (vulnerable to injection) |
| `PreparedStatement` | Executes parameterized SQL (safe & fast) |
| `ResultSet` | Holds result of SELECT query |
| `setAutoCommit(false)` | Starts a manual transaction |
| `commit()` | Permanently saves all changes in transaction |
| `rollback()` | Reverts all changes if an error occurs |
| `finally` block | Always closes connection to prevent leaks |
| **ACID** | Atomicity, Consistency, Isolation, Durability |
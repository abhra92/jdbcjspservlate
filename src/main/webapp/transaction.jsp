<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction Management Demo</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container container--narrow">
        <a href="index.jsp" class="btn-back">Back to Home</a>

        <div class="card">
            <h1>Transaction Management Demo</h1>
            <p class="subtitle">Demonstrating ACID properties with bank account transfers using commit and rollback</p>
        </div>

        <%
            List<Map<String, Object>> accounts = (List<Map<String, Object>>) request.getAttribute("accounts");
        %>

        <div class="card">
            <h2>Account Balances</h2>
            <% if (accounts != null && !accounts.isEmpty()) { %>
            <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>Account ID</th>
                        <th>Name</th>
                        <th>Balance</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map<String, Object> acc : accounts) { %>
                    <tr>
                        <td><strong><%= acc.get("accId") %></strong></td>
                        <td><%= acc.get("name") %></td>
                        <td><%= String.format("%.2f", acc.get("balance")) %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            </div>
            <% } else { %>
            <p style="color: var(--color-slate); text-align: center; padding: 20px;">
                No accounts found. Please run the database setup script.
            </p>
            <% } %>
        </div>

        <% if (accounts != null && accounts.size() >= 2) { %>
        <div class="card">
            <h2>Transfer Funds</h2>
            <form method="POST" action="transaction">
                <div class="form-group">
                    <label for="fromAcc">From Account</label>
                    <select id="fromAcc" name="fromAcc" required>
                        <% for (Map<String, Object> acc : accounts) { %>
                        <option value="<%= acc.get("accId") %>"
                            <%= String.valueOf(acc.get("accId")).equals(request.getAttribute("fromAcc")) ? "selected" : "" %>>
                            #<%= acc.get("accId") %> - <%= acc.get("name") %> (Balance: <%= String.format("%.2f", acc.get("balance")) %>)
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="toAcc">To Account</label>
                    <select id="toAcc" name="toAcc" required>
                        <% for (Map<String, Object> acc : accounts) { %>
                        <option value="<%= acc.get("accId") %>"
                            <%= String.valueOf(acc.get("accId")).equals(request.getAttribute("toAcc")) ? "selected" : "" %>>
                            #<%= acc.get("accId") %> - <%= acc.get("name") %> (Balance: <%= String.format("%.2f", acc.get("balance")) %>)
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="amount">Amount</label>
                    <input type="number" id="amount" name="amount" min="1" step="0.01"
                           value="<%= request.getAttribute("amount") != null ? request.getAttribute("amount") : "" %>"
                           placeholder="Enter transfer amount" required>
                </div>
                <button type="submit" class="btn btn-primary btn--full-width" style="margin-top: 20px;">Transfer</button>
            </form>
        </div>
        <% } %>

        <% if (request.getAttribute("transferResult") != null) { %>
        <div class="card">
            <h2>Transfer Result</h2>
            <div class="result-card">
                <div class="result-row">
                    <span class="result-label">Status</span>
                    <span class="result-value <%= request.getAttribute("transferResult") %>">
                        <%= "committed".equals(request.getAttribute("transferResult")) ? "Committed" : "Rolled Back" %>
                    </span>
                </div>
                <div class="result-row">
                    <span class="result-label">From Account</span>
                    <span class="result-value">#<%= request.getAttribute("fromAcc") %></span>
                </div>
                <div class="result-row">
                    <span class="result-label">To Account</span>
                    <span class="result-value">#<%= request.getAttribute("toAcc") %></span>
                </div>
                <div class="result-row">
                    <span class="result-label">Amount</span>
                    <span class="result-value"><%= request.getAttribute("amount") %></span>
                </div>
            </div>
            <div class="result-message">
                <%= request.getAttribute("transferMessage") %>
            </div>
        </div>
        <% } %>

        <div class="card">
            <h2>ACID Properties</h2>
            <div class="info-section">
                <p>Transactions ensure data integrity by grouping multiple operations into a single atomic unit. If any operation fails, all changes are rolled back.</p>
                <div class="info-grid">
                    <div class="info-item">
                        <h3>Atomicity</h3>
                        <p>All operations succeed or none succeed. No partial updates.</p>
                    </div>
                    <div class="info-item">
                        <h3>Consistency</h3>
                        <p>Database state remains valid before and after the transaction.</p>
                    </div>
                    <div class="info-item">
                        <h3>Isolation</h3>
                        <p>Concurrent transactions do not interfere with each other.</p>
                    </div>
                    <div class="info-item">
                        <h3>Durability</h3>
                        <p>Committed data survives system failures and crashes.</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <h2>Transaction Flow</h2>
            <ul class="flow-list">
                <li>
                    <span class="flow-step">1.</span>
                    <span class="flow-desc">setAutoCommit(false) - Start manual transaction control</span>
                </li>
                <li>
                    <span class="flow-step">2.</span>
                    <span class="flow-desc">UPDATE (debit) - Subtract amount from sender account</span>
                </li>
                <li>
                    <span class="flow-step">3.</span>
                    <span class="flow-desc">SELECT balance - Verify sufficient funds remain</span>
                </li>
                <li>
                    <span class="flow-step">4.</span>
                    <span class="flow-desc">UPDATE (credit) - Add amount to receiver account</span>
                </li>
                <li>
                    <span class="flow-step">5.</span>
                    <span class="flow-desc">commit() or rollback() - Save all changes or undo everything</span>
                </li>
            </ul>
        </div>
    </div>
</body>
</html>

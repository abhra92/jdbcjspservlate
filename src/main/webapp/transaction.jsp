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
    <style>
        :root {
            --color-ink: #101010;
            --color-white: #ffffff;
            --color-paper: #f4f4f4;
            --color-graphite: #242424;
            --color-slate: #6b7280;
            --color-silver: #e5e7eb;
            --shadow-card: rgba(34, 42, 53, 0.05) 0px 4px 8px 0px;
            --shadow-cta-hover: rgba(36, 36, 36, 0.7) 0px 1px 5px -4px;
        }
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background-color: var(--color-paper);
            color: var(--color-graphite);
            min-height: 100vh;
            padding: 20px;
            font-weight: 300;
            font-size: 16px;
            line-height: 1.5;
            letter-spacing: -0.19px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        .card {
            background-color: var(--color-white);
            border-radius: 12px;
            box-shadow: var(--shadow-card);
            padding: 24px;
            margin-bottom: 16px;
        }
        h1 {
            color: var(--color-graphite);
            font-size: 24px;
            font-weight: 600;
            line-height: 1.3;
            letter-spacing: 0.02em;
            margin-bottom: 8px;
            text-align: center;
        }
        h2 {
            color: var(--color-graphite);
            font-size: 20px;
            font-weight: 600;
            line-height: 1.3;
            letter-spacing: 0.02em;
            margin-bottom: 12px;
        }
        h3 {
            color: var(--color-graphite);
            font-size: 16px;
            font-weight: 600;
            letter-spacing: 0.01em;
            margin-bottom: 8px;
        }
        .subtitle {
            text-align: center;
            color: var(--color-slate);
            font-size: 14px;
            font-weight: 400;
            letter-spacing: -0.2px;
            margin-bottom: 24px;
        }
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 16px;
            border-radius: 9999px;
            font-size: 14px;
            font-weight: 500;
            color: var(--color-graphite);
            text-decoration: none;
            border: 1px solid var(--color-silver);
            transition: border-color 200ms ease;
            margin-bottom: 16px;
        }
        .btn-back:hover {
            border-color: var(--color-graphite);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table thead {
            background-color: var(--color-paper);
        }
        table th {
            padding: 12px 16px;
            text-align: left;
            font-size: 14px;
            font-weight: 500;
            letter-spacing: -0.2px;
            color: var(--color-graphite);
        }
        table td {
            padding: 12px 16px;
            border-bottom: 1px solid var(--color-silver);
            font-size: 16px;
            font-weight: 300;
            letter-spacing: -0.19px;
            color: var(--color-graphite);
        }
        table tbody tr:hover {
            background-color: var(--color-paper);
        }
        .form-group {
            margin-bottom: 16px;
        }
        label {
            display: block;
            margin-bottom: 6px;
            color: var(--color-graphite);
            font-size: 14px;
            font-weight: 500;
        }
        select,
        input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--color-silver);
            border-radius: 8px;
            font-family: inherit;
            font-size: 14px;
            font-weight: 300;
            color: var(--color-graphite);
            background-color: var(--color-white);
            transition: border-color 200ms ease;
            appearance: auto;
        }
        select:focus,
        input[type="number"]:focus {
            outline: none;
            border-color: var(--color-ink);
        }
        .btn-primary {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            padding: 12px 24px;
            border-radius: 9999px;
            cursor: pointer;
            font-family: inherit;
            font-size: 14px;
            font-weight: 500;
            background-color: var(--color-ink);
            color: var(--color-white);
            border: none;
            transition: all 200ms ease;
            margin-top: 20px;
        }
        .btn-primary:hover {
            box-shadow: var(--shadow-cta-hover);
        }
        .result-card {
            background-color: var(--color-paper);
            border-radius: 8px;
            padding: 16px;
            margin-top: 12px;
        }
        .result-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid var(--color-silver);
            font-size: 14px;
        }
        .result-row:last-child {
            border-bottom: none;
        }
        .result-label {
            font-weight: 500;
            color: var(--color-graphite);
        }
        .result-value {
            color: var(--color-slate);
            text-align: right;
            max-width: 60%;
        }
        .result-value.committed {
            font-weight: 600;
            color: var(--color-graphite);
        }
        .result-value.rolled_back {
            font-weight: 400;
            color: var(--color-slate);
        }
        .result-message {
            margin-top: 12px;
            padding: 12px;
            background-color: var(--color-white);
            border: 1px solid var(--color-silver);
            border-radius: 8px;
            font-size: 14px;
            color: var(--color-graphite);
        }
        .info-section {
            font-size: 14px;
            color: var(--color-graphite);
        }
        .info-section p {
            margin-bottom: 12px;
            line-height: 1.6;
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            margin-top: 12px;
        }
        .info-item {
            background-color: var(--color-paper);
            border-radius: 8px;
            padding: 12px;
        }
        .info-item h3 {
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 4px;
        }
        .info-item p {
            font-size: 13px;
            color: var(--color-slate);
            margin-bottom: 0;
        }
        .flow-list {
            list-style: none;
            padding: 0;
            margin-top: 12px;
        }
        .flow-list li {
            padding: 8px 12px;
            border-bottom: 1px solid var(--color-silver);
            font-size: 14px;
            display: flex;
            gap: 8px;
        }
        .flow-list li:last-child {
            border-bottom: none;
        }
        .flow-step {
            font-weight: 600;
            color: var(--color-graphite);
            min-width: 20px;
        }
        .flow-desc {
            color: var(--color-slate);
        }
        @media (max-width: 768px) {
            .card {
                padding: 16px;
            }
            .info-grid {
                grid-template-columns: 1fr;
            }
            .result-row {
                flex-direction: column;
                gap: 4px;
            }
            .result-value {
                max-width: 100%;
                text-align: left;
            }
            select,
            input[type="number"] {
                min-height: 44px;
            }
            .btn-primary {
                min-height: 44px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
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
                <button type="submit" class="btn-primary">Transfer</button>
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

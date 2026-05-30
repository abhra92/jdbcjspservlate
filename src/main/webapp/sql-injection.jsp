<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SQL Injection Prevention Demo</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container container--narrow">
        <a href="index.jsp" class="btn-back">Back to Home</a>

        <div class="card">
            <h1>SQL Injection Prevention Demo</h1>
            <p class="subtitle">Compare vulnerable Statement queries vs. safe PreparedStatement queries</p>

            <form method="POST" action="sql-injection">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username"
                           value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
                           placeholder="Enter username (e.g., alice)" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="text" id="password" name="password"
                           value="<%= request.getAttribute("password") != null ? request.getAttribute("password") : "" %>"
                           placeholder="Enter password (e.g., pass123)" required>
                </div>
                <div class="button-group">
                    <button type="submit" name="method" value="vulnerable" class="btn btn-secondary">
                        Test Vulnerable (Statement)
                    </button>
                    <button type="submit" name="method" value="safe" class="btn btn-primary">
                        Test Safe (PreparedStatement)
                    </button>
                </div>
            </form>
        </div>

        <% if (request.getAttribute("result") != null) { %>
        <div class="card">
            <h2>Result</h2>
            <div class="result-card">
                <div class="result-row">
                    <span class="result-label">Method</span>
                    <span class="result-value">
                        <%= "vulnerable".equals(request.getAttribute("method")) ? "Vulnerable (Statement)" : "Safe (PreparedStatement)" %>
                    </span>
                </div>
                <div class="result-row">
                    <span class="result-label">Outcome</span>
                    <span class="result-value <%= "success".equals(request.getAttribute("result")) ? "success" : "failed" %>">
                        <%= "success".equals(request.getAttribute("result")) ? "Login Success" : "Login Failed" %>
                        <% if (request.getAttribute("user") != null) { %>
                            (User: <%= request.getAttribute("user") %>)
                        <% } %>
                    </span>
                </div>
            </div>
            <h3 style="margin-top: 16px;">SQL Query Executed</h3>
            <div class="sql-display"><%= request.getAttribute("sqlQuery") %></div>
        </div>
        <% } %>

        <div class="card">
            <h2>Injection Examples to Try</h2>
            <p style="color: var(--color-slate); font-size: 14px; margin-bottom: 12px;">
                Enter these payloads in the Username or Password field and compare results between Vulnerable and Safe methods.
            </p>
            <ul class="examples-list">
                <li>
                    <span class="example-code">' OR '1'='1</span>
                    <p class="example-desc">Always-true condition. Bypasses authentication with the vulnerable method.</p>
                </li>
                <li>
                    <span class="example-code">' OR '1'='1' --</span>
                    <p class="example-desc">Comments out the password check entirely.</p>
                </li>
                <li>
                    <span class="example-code">alice' --</span>
                    <p class="example-desc">Logs in as alice without knowing the password (use as Username, leave Password empty or any value).</p>
                </li>
                <li>
                    <span class="example-code">' UNION SELECT 1,2,3,4 --</span>
                    <p class="example-desc">Attempts a UNION-based injection to extract data.</p>
                </li>
            </ul>
        </div>

        <div class="card">
            <h2>Statement vs PreparedStatement</h2>
            <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>Feature</th>
                        <th>Statement</th>
                        <th>PreparedStatement</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Query Type</td>
                        <td>Dynamic string concatenation</td>
                        <td>Pre-compiled template</td>
                    </tr>
                    <tr>
                        <td>Input Handling</td>
                        <td>Concatenated as SQL code</td>
                        <td>Treated as DATA only</td>
                    </tr>
                    <tr>
                        <td>SQL Injection Risk</td>
                        <td>HIGH</td>
                        <td>NONE</td>
                    </tr>
                    <tr>
                        <td>Performance</td>
                        <td>Slower (re-parsed each time)</td>
                        <td>Faster (cached execution plan)</td>
                    </tr>
                    <tr>
                        <td>Readability</td>
                        <td>Poor (string concatenation)</td>
                        <td>Clean (placeholder syntax)</td>
                    </tr>
                    <tr>
                        <td>Recommended</td>
                        <td>NO</td>
                        <td>YES</td>
                    </tr>
                </tbody>
            </table>
            </div>
        </div>
    </div>
</body>
</html>

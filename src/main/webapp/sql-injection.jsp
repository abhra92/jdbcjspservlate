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
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--color-silver);
            border-radius: 8px;
            font-family: inherit;
            font-size: 14px;
            font-weight: 300;
            color: var(--color-graphite);
            transition: border-color 200ms ease;
        }
        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: var(--color-ink);
        }
        .button-group {
            display: flex;
            gap: 12px;
            margin-top: 20px;
        }
        .btn {
            flex: 1;
            padding: 12px 24px;
            border-radius: 9999px;
            cursor: pointer;
            font-family: inherit;
            font-size: 14px;
            font-weight: 500;
            transition: all 200ms ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: none;
        }
        .btn-primary {
            background-color: var(--color-ink);
            color: var(--color-white);
        }
        .btn-primary:hover {
            box-shadow: var(--shadow-cta-hover);
        }
        .btn-secondary {
            background-color: transparent;
            color: var(--color-graphite);
            border: 1px solid var(--color-silver);
        }
        .btn-secondary:hover {
            border-color: var(--color-graphite);
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
        .result-card {
            background-color: var(--color-paper);
            border-radius: 8px;
            padding: 16px;
            margin-top: 16px;
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
            font-family: monospace;
            font-size: 13px;
            word-break: break-all;
            max-width: 60%;
            text-align: right;
        }
        .result-value.success {
            font-weight: 600;
            color: var(--color-graphite);
        }
        .result-value.failed {
            font-weight: 400;
            color: var(--color-slate);
        }
        .sql-display {
            background-color: var(--color-paper);
            border: 1px solid var(--color-silver);
            border-radius: 8px;
            padding: 12px;
            font-family: monospace;
            font-size: 13px;
            word-break: break-all;
            margin-top: 8px;
            color: var(--color-graphite);
        }
        .examples-list {
            list-style: none;
            padding: 0;
        }
        .examples-list li {
            padding: 10px 12px;
            border-bottom: 1px solid var(--color-silver);
            font-size: 14px;
        }
        .examples-list li:last-child {
            border-bottom: none;
        }
        .example-code {
            font-family: monospace;
            font-size: 13px;
            background-color: var(--color-paper);
            padding: 2px 6px;
            border-radius: 4px;
        }
        .example-desc {
            color: var(--color-slate);
            font-size: 13px;
            margin-top: 4px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 12px;
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
            font-size: 14px;
            font-weight: 300;
            letter-spacing: -0.2px;
            color: var(--color-graphite);
        }
        @media (max-width: 768px) {
            .card {
                padding: 16px;
            }
            .button-group {
                flex-direction: column;
            }
            .btn {
                min-height: 44px;
            }
            .result-row {
                flex-direction: column;
                gap: 4px;
            }
            .result-value {
                max-width: 100%;
                text-align: left;
            }
            input[type="text"],
            input[type="password"] {
                min-height: 44px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
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
</body>
</html>

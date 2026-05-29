<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome - Student Management System</title>
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
            --font-stack: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            --card-shadow: rgba(34, 42, 53, 0.05) 0px 4px 8px 0px;
        }
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: var(--font-stack);
            background-color: var(--color-paper);
            color: var(--color-graphite);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 48px 0;
        }
        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            text-align: center;
        }
        .card {
            background-color: var(--color-white);
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            padding: 24px;
        }
        .hero {
            margin-bottom: 16px;
            padding: 48px 24px;
        }
        h1 {
            font-family: var(--font-stack);
            font-size: 48px;
            font-weight: 600;
            color: var(--color-graphite);
            line-height: 1.1;
            letter-spacing: 0.02em;
            margin-bottom: 16px;
        }
        .subtitle {
            font-family: var(--font-stack);
            font-size: 16px;
            font-weight: 300;
            color: var(--color-slate);
            line-height: 1.6;
            letter-spacing: -0.19px;
            max-width: 640px;
            margin: 0 auto;
        }
        .features {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
            margin: 16px 0;
            text-align: left;
        }
        .feature {
            background-color: var(--color-white);
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            padding: 24px;
        }
        .feature h3 {
            font-family: var(--font-stack);
            font-size: 20px;
            font-weight: 600;
            color: var(--color-graphite);
            line-height: 1.3;
            letter-spacing: 0.02em;
            margin-bottom: 8px;
        }
        .feature p {
            font-family: var(--font-stack);
            font-size: 14px;
            font-weight: 300;
            color: var(--color-slate);
            line-height: 1.5;
            letter-spacing: -0.2px;
            margin: 0;
        }
        .buttons {
            display: flex;
            gap: 12px;
            margin: 16px 0;
            justify-content: center;
            flex-wrap: wrap;
        }
        .btn {
            font-family: var(--font-stack);
            font-size: 14px;
            font-weight: 500;
            border-radius: 9999px;
            padding: 12px 24px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 200ms ease;
        }
        .btn-primary {
            background-color: var(--color-ink);
            color: var(--color-white);
            border: 1px solid var(--color-ink);
        }
        .btn-primary:hover {
            box-shadow: rgba(36, 36, 36, 0.7) 0px 1px 5px -4px;
        }
        .btn-secondary {
            background-color: transparent;
            color: var(--color-graphite);
            border: 1px solid var(--color-silver);
        }
        .btn-secondary:hover {
            border-color: var(--color-graphite);
        }
        .tech-stack {
            background-color: var(--color-white);
            color: var(--color-graphite);
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            padding: 24px;
            margin-top: 16px;
            text-align: left;
        }
        .tech-stack h3 {
            font-family: var(--font-stack);
            font-size: 20px;
            font-weight: 600;
            color: var(--color-graphite);
            line-height: 1.3;
            letter-spacing: 0.02em;
            margin-bottom: 12px;
        }
        .tech-stack p {
            font-family: var(--font-stack);
            font-size: 14px;
            font-weight: 300;
            color: var(--color-graphite);
            line-height: 1.5;
            letter-spacing: -0.2px;
            margin: 6px 0;
        }
        @media (max-width: 768px) {
            body {
                padding: 24px 0;
            }
            .card,
            .hero,
            .feature,
            .tech-stack {
                padding: 16px;
            }
            h1 {
                font-size: 32px;
            }
            .features {
                grid-template-columns: 1fr;
            }
            .buttons {
                flex-direction: column;
            }
            .btn {
                width: 100%;
                min-height: 44px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card hero">
            <h1>Student Management System</h1>
            <p class="subtitle">A comprehensive JDBC + JSP/Servlet application with complete CRUD operations</p>
        </div>

        <div class="features">
            <div class="feature">
                <h3>Full CRUD</h3>
                <p>Create, Read, Update, Delete student records</p>
            </div>
            <div class="feature">
                <h3>SQL Injection Prevention</h3>
                <p>PreparedStatement for secure database access</p>
            </div>
            <div class="feature">
                <h3>Modern UI</h3>
                <p>Responsive and user-friendly interface</p>
            </div>
            <div class="feature">
                <h3>Responsive Design</h3>
                <p>Works seamlessly on all devices</p>
            </div>
        </div>

        <div class="buttons">
<%--            <a href="student?action=list" class="btn btn-primary">Go to Student List</a>--%>
            <a href="student-form.jsp" class="btn btn-secondary">Add New Student</a>
            <a href="student?action=list" class="btn btn-secondary">Student Details</a>
            <a href="sql-injection" class="btn btn-secondary">SQL Injection Demo</a>
            <a href="transaction" class="btn btn-secondary">Transaction Demo</a>
        </div>

        <div class="tech-stack">
            <h3>Technology Stack</h3>
            <p>Java Servlets &amp; JSP</p>
            <p>MySQL JDBC Driver</p>
            <p>Apache Tomcat</p>
            <p>Maven Build System</p>
        </div>
    </div>
</body>
</html>

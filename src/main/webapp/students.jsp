<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.jdbcjspservlate.Student" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management System</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --color-ink: #101010;
            --color-action-blue: #0099ff;
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
            max-width: 1200px;
            margin: 0 auto;
            background-color: var(--color-white);
            border-radius: 12px;
            box-shadow: var(--shadow-card);
            padding: 24px;
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
        .subtitle {
            text-align: center;
            color: var(--color-slate);
            font-size: 16px;
            font-weight: 300;
            letter-spacing: -0.19px;
            margin-bottom: 24px;
        }
        h2 {
            color: var(--color-graphite);
            font-size: 20px;
            font-weight: 600;
            line-height: 1.3;
            letter-spacing: 0.02em;
        }
        .button-group {
            display: flex;
            gap: 16px;
            margin-bottom: 16px;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }
        .btn {
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-family: inherit;
            border: none;
            transition: all 200ms ease;
        }
        .btn-primary {
            background-color: var(--color-ink);
            color: var(--color-white);
            border-radius: 9999px;
            padding: 12px 24px;
            font-size: 14px;
            font-weight: 500;
            letter-spacing: -0.2px;
        }
        .btn-primary:hover {
            box-shadow: var(--shadow-cta-hover);
        }
        .btn-action {
            background-color: var(--color-ink);
            color: var(--color-white);
            border-radius: 8px;
            padding: 8px 16px;
            font-size: 12px;
            font-weight: 500;
            letter-spacing: -0.24px;
        }
        .btn-action:hover {
            background-color: var(--color-graphite);
        }
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }
        .stat-card {
            background-color: var(--color-white);
            color: var(--color-graphite);
            padding: 24px;
            border-radius: 12px;
            box-shadow: var(--shadow-card);
            text-align: center;
        }
        .stat-card h3 {
            font-size: 48px;
            font-weight: 600;
            line-height: 1.1;
            letter-spacing: 0.02em;
            color: var(--color-graphite);
            margin-bottom: 4px;
        }
        .stat-card p {
            font-size: 14px;
            font-weight: 400;
            letter-spacing: -0.2px;
            color: var(--color-slate);
        }
        .table-wrap {
            width: 100%;
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 16px;
            background-color: var(--color-white);
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
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        .no-data {
            text-align: center;
            padding: 40px;
            color: var(--color-slate);
            font-size: 16px;
            font-weight: 300;
            letter-spacing: -0.19px;
        }
        .no-data a {
            color: var(--color-action-blue);
            text-decoration: underline;
        }
        .alert {
            padding: 16px;
            margin-bottom: 16px;
            border-radius: 12px;
            background-color: var(--color-white);
            color: var(--color-graphite);
            border: 1px solid var(--color-silver);
            font-size: 14px;
            font-weight: 400;
            letter-spacing: -0.2px;
        }
        @media (max-width: 768px) {
            .container {
                padding: 16px;
            }
            .stats {
                grid-template-columns: 1fr;
            }
            .stat-card {
                padding: 16px;
            }
            .button-group {
                flex-direction: column;
                align-items: stretch;
            }
            .btn {
                min-height: 44px;
                min-width: 44px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="index.jsp" style="display:inline-flex;align-items:center;gap:6px;padding:8px 16px;border-radius:9999px;font-size:14px;font-weight:500;color:var(--color-graphite);text-decoration:none;border:1px solid var(--color-silver);transition:border-color 200ms ease;margin-bottom:16px;">Back to Home</a>
        <h1>Student Management System</h1>
        <p class="subtitle">JDBC + JSP/Servlet CRUD Operations</p>

        <%-- Display success/error messages --%>
        <% String error = request.getParameter("error");
           String success = request.getParameter("success");
           if (error != null) { %>
            <div class="alert">
                <%= error %>
            </div>
        <% } %>
        <% if (success != null) { %>
            <div class="alert">
                <%= success %>
            </div>
        <% } %>

        <%-- Statistics --%>
        <div class="stats">
            <div class="stat-card">
                <h3><%= request.getAttribute("students") != null ?
                    ((List<Student>) request.getAttribute("students")).size() : 0 %></h3>
                <p>Total Students</p>
            </div>
        </div>

        <%-- Add New Student Button --%>
        <div class="button-group">
            <h2>Students List</h2>
            <a href="student-form.jsp" class="btn btn-primary">Add New Student</a>
        </div>

        <%-- Students Table --%>
        <%
            List<Student> students = (List<Student>) request.getAttribute("students");
            if (students != null && !students.isEmpty()) {
        %>
        <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Email</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Student student : students) {
                %>
                <tr>
                    <td><strong><%= student.getId() %></strong></td>
                    <td><%= student.getName() %></td>
                    <td><%= student.getAge() %></td>
                    <td><%= student.getEmail() %></td>
                    <td>
                        <div class="action-buttons">
                            <a href="student?action=view&id=<%= student.getId() %>" class="btn btn-action">View</a>
                            <a href="student?action=edit&id=<%= student.getId() %>" class="btn btn-action">Edit</a>
                            <a href="student?action=delete&id=<%= student.getId() %>" class="btn btn-action"
                               onclick="return confirm('Are you sure?');">Delete</a>
                        </div>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        </div>
        <%
            } else {
        %>
        <div class="no-data">
            <p>No students found. <a href="student-form.jsp">Add one now!</a></p>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.jdbcjspservlate.Student" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Details</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background-color: #f4f4f4;
            color: #242424;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .container {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: rgba(34, 42, 53, 0.05) 0px 4px 8px 0px;
            padding: 24px;
            width: 100%;
            max-width: 500px;
        }
        h1 {
            color: #242424;
            font-size: 24px;
            font-weight: 600;
            letter-spacing: 0.02em;
            margin-bottom: 8px;
            text-align: center;
        }
        .subtitle {
            text-align: center;
            color: #6b7280;
            font-size: 14px;
            font-weight: 400;
            margin-bottom: 24px;
        }
        .info-card {
            background-color: #101010;
            border-radius: 12px;
            box-shadow: rgba(34, 42, 53, 0.05) 0px 4px 8px 0px;
            padding: 24px;
            text-align: center;
            margin-bottom: 24px;
        }
        .info-card h2 {
            color: #ffffff;
            font-size: 24px;
            font-weight: 600;
            letter-spacing: 0.02em;
            margin-bottom: 5px;
        }
        .info-card p {
            color: #ffffff;
            font-size: 14px;
            font-weight: 300;
            letter-spacing: -0.2px;
        }
        .detail-group {
            margin-bottom: 16px;
            padding-bottom: 16px;
            border-bottom: 1px solid #e5e7eb;
        }
        .detail-group:last-of-type {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }
        .label {
            color: #6b7280;
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
        }
        .value {
            color: #242424;
            font-size: 18px;
            font-weight: 300;
            letter-spacing: -0.2px;
        }
        .value a {
            color: #0099ff;
            text-decoration: none;
        }
        .value a:hover {
            text-decoration: underline;
        }
        .button-group {
            display: flex;
            gap: 12px;
            margin-top: 24px;
        }
        .btn {
            flex: 1;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            font-size: 14px;
            font-weight: 500;
            padding: 12px 24px;
            border-radius: 9999px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: all 200ms ease;
        }
        .btn-primary {
            background-color: #101010;
            color: #ffffff;
            border: 1px solid #101010;
        }
        .btn-primary:hover {
            box-shadow: rgba(36, 36, 36, 0.7) 0px 1px 5px -4px;
        }
        .btn-secondary {
            background-color: transparent;
            color: #242424;
            border: 1px solid #e5e7eb;
        }
        .btn-secondary:hover {
            border-color: #242424;
        }
        .error-state {
            text-align: center;
            margin-top: 24px;
        }
        .error-state p {
            color: #6b7280;
            font-size: 14px;
            font-weight: 400;
            margin-bottom: 20px;
        }
        .error-state .btn {
            display: inline-block;
            flex: none;
            max-width: 200px;
        }
        @media (max-width: 768px) {
            .container {
                padding: 16px;
            }
            .info-card {
                padding: 16px;
            }
            .button-group {
                flex-direction: column;
            }
            .btn {
                min-height: 44px;
                display: flex;
                align-items: center;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="index.jsp" style="display:inline-flex;align-items:center;gap:6px;padding:8px 16px;border-radius:9999px;font-size:14px;font-weight:500;color:#242424;text-decoration:none;border:1px solid #e5e7eb;transition:border-color 200ms ease;margin-bottom:16px;">Back to Home</a>
        <%
            Student student = (Student) request.getAttribute("student");
            if (student != null) {
        %>

        <h1>Student Details</h1>
        <p class="subtitle">View student information</p>

        <div class="info-card">
            <h2><%= student.getName() %></h2>
            <p>Student ID: #<%= student.getId() %></p>
        </div>

        <div class="detail-group">
            <div class="label">Student ID</div>
            <div class="value"><%= student.getId() %></div>
        </div>

        <div class="detail-group">
            <div class="label">Full Name</div>
            <div class="value"><%= student.getName() %></div>
        </div>

        <div class="detail-group">
            <div class="label">Age</div>
            <div class="value"><%= student.getAge() %> years old</div>
        </div>

        <div class="detail-group">
            <div class="label">Email Address</div>
            <div class="value"><a href="mailto:<%= student.getEmail() %>">
                <%= student.getEmail() %>
            </a></div>
        </div>

        <div class="button-group">
            <a href="student?action=edit&id=<%= student.getId() %>" class="btn btn-primary">Edit</a>
            <a href="student?action=delete&id=<%= student.getId() %>" class="btn btn-secondary"
               onclick="return confirm('Are you sure you want to delete this student?');">Delete</a>
            <a href="student?action=list" class="btn btn-secondary">Back to List</a>
        </div>

        <%
            } else {
        %>

        <h1>Error</h1>
        <p class="subtitle">Student not found</p>
        <div class="error-state">
            <p>The student you're looking for doesn't exist.</p>
            <a href="student?action=list" class="btn btn-secondary">Back to List</a>
        </div>

        <%
            }
        %>
    </div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.jdbcjspservlate.Student" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Form</title>
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
            font-weight: 300;
            letter-spacing: -0.2px;
            background-color: #f4f4f4;
            color: #242424;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .card {
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
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #242424;
            font-size: 14px;
            font-weight: 500;
        }
        input[type="text"],
        input[type="email"],
        input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            font-family: inherit;
            font-size: 14px;
            font-weight: 300;
            color: #242424;
            transition: border-color 200ms ease;
        }
        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="number"]:focus {
            outline: none;
            border-color: #101010;
            box-shadow: none;
        }
        .button-group {
            display: flex;
            gap: 12px;
            margin-top: 24px;
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
            display: inline-block;
            text-align: center;
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
        .alert {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-size: 14px;
        }
        .alert-error {
            background-color: #f4f4f4;
            color: #242424;
        }
        @media (max-width: 768px) {
            .card {
                padding: 16px;
            }
            input[type="text"],
            input[type="email"],
            input[type="number"] {
                min-height: 44px;
            }
            .btn {
                min-height: 44px;
                min-width: 44px;
            }
        }
    </style>
</head>
<body>
    <a href="index.jsp" style="display:inline-flex;align-items:center;gap:6px;padding:8px 16px;border-radius:9999px;font-size:14px;font-weight:500;color:#242424;text-decoration:none;border:1px solid #e5e7eb;transition:border-color 200ms ease;margin-bottom:16px;">Back to Home</a>
    <div class="card">
        <%
            Student student = (Student) request.getAttribute("student");
            String pageTitle = student != null ? "Edit Student" : "Add New Student";
            String action = student != null ? "update" : "add";
        %>

        <h1><%= pageTitle %></h1>
        <p class="subtitle">JDBC + JSP/Servlet Form</p>

        <%-- Display error message --%>
        <% String error = request.getParameter("error");
           if (error != null) { %>
            <div class="alert alert-error">
                <%= error %>
            </div>
        <% } %>

        <form method="POST" action="student?action=<%= action %>">
            <%-- Hidden field for student ID (edit mode only) --%>
            <% if (student != null) { %>
                <input type="hidden" name="id" value="<%= student.getId() %>">
            <% } %>

            <%-- Name Field --%>
            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name"
                       value="<%= student != null ? student.getName() : "" %>"
                       required>
            </div>

            <%-- Age Field --%>
            <div class="form-group">
                <label for="age">Age</label>
                <input type="number" id="age" name="age"
                       min="1" max="100"
                       value="<%= student != null ? student.getAge() : "" %>"
                       required>
            </div>

            <%-- Email Field --%>
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email"
                       value="<%= student != null ? student.getEmail() : "" %>"
                       required>
            </div>

            <%-- Buttons --%>
            <div class="button-group">
                <button type="submit" class="btn btn-primary">
                    <%= student != null ? "Update Student" : "Add Student" %>
                </button>
                <a href="student?action=list" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>

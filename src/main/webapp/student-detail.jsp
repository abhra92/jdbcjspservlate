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
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="body--centered">
    <div class="container container--form">
        <a href="index.jsp" class="btn-back">Back to Home</a>

        <div class="card">
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
    </div>
</body>
</html>

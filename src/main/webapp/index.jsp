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
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="body--centered">
    <div class="container" style="text-align: center;">
        <div class="card hero">
            <h1>Student Management System</h1>
            <p class="subtitle subtitle--large">A comprehensive JDBC + JSP/Servlet application with complete CRUD operations</p>
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

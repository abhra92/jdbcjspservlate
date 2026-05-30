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
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="body--centered">
    <div class="container container--form">
        <a href="index.jsp" class="btn-back">Back to Home</a>

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
    </div>
</body>
</html>

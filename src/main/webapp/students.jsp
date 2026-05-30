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
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <a href="index.jsp" class="btn-back">Back to Home</a>

        <div class="card">
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
            <div class="button-group button-group--between">
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
    </div>
</body>
</html>

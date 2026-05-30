package com.example.jdbcjspservlate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Student Servlet
 * Handles HTTP requests for student CRUD operations
 */
@WebServlet(name = "StudentServlet", value = "/student")
public class StudentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listStudents(request, response);
                break;
            case "view":
                viewStudent(request, response);
                break;
            case "edit":
                editStudent(request, response);
                break;
            case "delete":
                deleteStudent(request, response);
                break;
            default:
                listStudents(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                addStudent(request, response);
                break;
            case "update":
                updateStudent(request, response);
                break;
            default:
                listStudents(request, response);
        }
    }

    /**
     * List all students
     */
    private void listStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Student> students = StudentDAO.getAllStudents();
        request.setAttribute("students", students);
        request.getRequestDispatcher("/students.jsp").forward(request, response);
    }

    /**
     * View a specific student
     */
    private void viewStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Student student = StudentDAO.getStudentById(id);
        request.setAttribute("student", student);
        request.getRequestDispatcher("/student-detail.jsp").forward(request, response);
    }

    /**
     * Show edit form
     */
    private void editStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Student student = StudentDAO.getStudentById(id);
        request.setAttribute("student", student);
        request.getRequestDispatcher("/student-form.jsp").forward(request, response);
    }

    /**
     * Add a new student
     */
    private void addStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String email = request.getParameter("email");

        Student student = new Student(name, age, email);
        boolean success = StudentDAO.insertStudent(student);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/student?action=list");
        } else {
            response.sendRedirect(request.getContextPath() + "/student-form.jsp?error=Failed to add student");
        }
    }

    /**
     * Update an existing student
     */
    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String email = request.getParameter("email");

        boolean success = StudentDAO.updateStudent(id, name, age, email);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/student?action=list");
        } else {
            response.sendRedirect(request.getContextPath() + "/student?action=edit&id=" + id + "&error=Failed to update");
        }
    }

    /**
     * Delete a student
     */
    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = StudentDAO.deleteStudent(id);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/student?action=list");
        } else {
            response.sendRedirect(request.getContextPath() + "/student?action=list&error=Failed to delete student");
        }
    }
}


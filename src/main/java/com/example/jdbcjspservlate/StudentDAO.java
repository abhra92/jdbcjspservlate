package com.example.jdbcjspservlate;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Student Data Access Object (DAO)
 * Handles all CRUD operations for Student records
 */
public class StudentDAO {

    /**
     * 1️⃣ CREATE - Insert a new student into the database
     * @param student Student object to insert
     * @return true if insertion was successful, false otherwise
     */
    public static boolean insertStudent(Student student) {
        String sql = "INSERT INTO students (name, age, email) VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, student.getName());
            ps.setInt(2, student.getAge());
            ps.setString(3, student.getEmail());

            int rows = ps.executeUpdate();
            System.out.println("✅ INSERT SUCCESS — Rows affected: " + rows);
            return rows > 0;

        } catch (SQLException e) {
            System.out.println("❌ INSERT FAILED: " + e.getMessage());
            return false;
        }
    }

    /**
     * 2️⃣ READ - Fetch all students from the database
     * @return List of all Student objects
     */
    public static List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students";

        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Student student = new Student(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getInt("age"),
                    rs.getString("email")
                );
                students.add(student);
            }
            System.out.println("✅ READ SUCCESS — Students fetched: " + students.size());

        } catch (SQLException e) {
            System.out.println("❌ READ FAILED: " + e.getMessage());
        }
        return students;
    }

    /**
     * 2️⃣ READ - Fetch a student by ID
     * @param id Student ID
     * @return Student object if found, null otherwise
     */
    public static Student getStudentById(int id) {
        String sql = "SELECT * FROM students WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Student student = new Student(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getInt("age"),
                    rs.getString("email")
                );
                System.out.println("✅ STUDENT FOUND: " + student);
                return student;
            } else {
                System.out.println("⚠️  No student found with ID: " + id);
                return null;
            }

        } catch (SQLException e) {
            System.out.println("❌ READ FAILED: " + e.getMessage());
            return null;
        }
    }

    /**
     * 3️⃣ UPDATE - Update a student's email by ID
     * @param id Student ID
     * @param newEmail New email address
     * @return true if update was successful, false otherwise
     */
    public static boolean updateStudent(int id, String name, int age, String email) {
        String sql = "UPDATE students SET name = ?, age = ?, email = ? WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setInt(2, age);
            ps.setString(3, email);
            ps.setInt(4, id);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("✅ UPDATE SUCCESS — Student ID " + id + " updated.");
                return true;
            } else {
                System.out.println("⚠️  No record found with ID: " + id);
                return false;
            }

        } catch (SQLException e) {
            System.out.println("❌ UPDATE FAILED: " + e.getMessage());
            return false;
        }
    }

    /**
     * 4️⃣ DELETE - Delete a student by ID
     * @param id Student ID
     * @return true if deletion was successful, false otherwise
     */
    public static boolean deleteStudent(int id) {
        String sql = "DELETE FROM students WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("✅ DELETE SUCCESS — Student ID " + id + " removed.");
                return true;
            } else {
                System.out.println("⚠️  No record found with ID: " + id);
                return false;
            }

        } catch (SQLException e) {
            System.out.println("❌ DELETE FAILED: " + e.getMessage());
            return false;
        }
    }

    /**
     * Display all students in formatted table
     */
    public static void displayAllStudents() {
        List<Student> students = getAllStudents();

        System.out.println("\n─────────────────────────────────────────────────────────");
        System.out.printf("%-5s %-20s %-5s %-25s%n",
            "ID", "NAME", "AGE", "EMAIL");
        System.out.println("─────────────────────────────────────────────────────────");

        for (Student student : students) {
            System.out.printf("%-5d %-20s %-5d %-25s%n",
                student.getId(),
                student.getName(),
                student.getAge(),
                student.getEmail());
        }
        System.out.println("─────────────────────────────────────────────────────────\n");
    }

    /**
     * Test CRUD operations
     */
    public static void main(String[] args) {
        System.out.println("📋 Testing CRUD Operations...\n");

        // CREATE
        System.out.println("════════ CREATE OPERATION ════════");
        insertStudent(new Student("Abhra", 22, "abhra@example.com"));
        insertStudent(new Student("Bca", 25, "bca@example.com"));
        insertStudent(new Student("Claude", 21, "claude@example.com"));

        // READ
        System.out.println("\n════════ READ ALL OPERATION ════════");
        displayAllStudents();

        // READ by ID
        System.out.println("════════ READ BY ID OPERATION ════════");
        getStudentById(1);

        // UPDATE
        System.out.println("\n════════ UPDATE OPERATION ════════");
        updateStudent(1, "Abhra Sara", 22, "abhra.sara@example.com");

        // READ after update
        System.out.println("\n════════ READ AFTER UPDATE ════════");
        displayAllStudents();

        // DELETE
        System.out.println("════════ DELETE OPERATION ════════");
        deleteStudent(3);

        // READ after delete
        System.out.println("\n════════ READ AFTER DELETE ════════");
        displayAllStudents();
    }
}


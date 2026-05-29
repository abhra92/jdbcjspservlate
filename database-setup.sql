-- ============================================================
-- MySQL Database Setup for Student Management System
-- ============================================================

-- Create the database
CREATE DATABASE IF NOT EXISTS studentdb;

-- Use the database
USE studentdb;

-- Create the students table
CREATE TABLE IF NOT EXISTS students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO students (name, age, email) VALUES
('Abhra', 22, 'abhra@example.com'),
('Bca', 25, 'bca@example.com'),
('Claude', 21, 'claude@example.com'),
('Alice', 23, 'alice@example.com'),
('Bob', 24, 'bob@example.com');

-- Verify the data
SELECT * FROM students;

-- ============================================================
-- Optional: Create a users table for SQL Injection demo
-- ============================================================

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- Insert sample user data
INSERT INTO users (username, password, email) VALUES
('alice', 'pass123', 'alice@example.com'),
('bob', 'pass456', 'bob@example.com'),
('charlie', 'pass789', 'charlie@example.com');

-- ============================================================
-- Optional: Create an accounts table for Transaction demo
-- ============================================================

CREATE TABLE IF NOT EXISTS accounts (
    acc_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    balance DOUBLE NOT NULL
);

-- Insert sample account data
INSERT INTO accounts (acc_id, name, balance) VALUES
(1, 'Alice', 10000),
(2, 'Bob', 5000),
(3, 'Charlie', 7500);

-- Verify setup
SHOW TABLES;
SELECT COUNT(*) as total_students FROM students;


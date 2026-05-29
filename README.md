# 📚 Student Management System - JDBC + JSP/Servlet

A complete Java web application demonstrating CRUD operations using JDBC, JSP, and Servlets with best practices for database security and transaction management.

## 🎯 Features

- ✅ **Complete CRUD Operations** - Create, Read, Update, Delete student records
- ✅ **SQL Injection Prevention** - Uses PreparedStatement for secure queries
- ✅ **Transaction Management** - Commit/Rollback with ACID properties
- ✅ **Modern UI** - Responsive web interface with gradient design
- ✅ **Maven Build System** - Easy dependency management
- ✅ **Best Practices** - Connection pooling, error handling, and proper resource management

## 📋 Prerequisites

- Java 8 or higher
- Maven 3.6+
- MySQL Server 5.7+
- Apache Tomcat 9+

## 🚀 Setup Instructions

### 1. Database Setup

#### Option A: Using MySQL Command Line
```bash
# Open MySQL command line
mysql -u root -p

# Execute the setup script
source /path/to/database-setup.sql
```

#### Option B: Using the SQL file
```bash
mysql -u root -p < database-setup.sql
```

### 2. Configure Database Connection

Edit `src/main/java/com/example/jdbcjspservlate/DBConnection.java`:

```java
static final String URL    = "jdbc:mysql://localhost:3306/studentdb";
static final String USER   = "root";
static final String PASS   = "abhrabca";  // Change to your MySQL password
```

### 3. Build and Run

#### Using Maven:
```bash
# Navigate to project directory
cd jdbcjspservlate

# Clean and build
mvn clean install

# Run with Maven Tomcat plugin
mvn tomcat7:run
```

#### Or deploy to Tomcat:
```bash
# Build WAR file
mvn clean package

# Copy to Tomcat webapps directory
cp target/jdbcjspservlate-1.0-SNAPSHOT.war $TOMCAT_HOME/webapps/

# Start Tomcat
$TOMCAT_HOME/bin/startup.sh
```

### 4. Access the Application

Open your browser and navigate to:
```
http://localhost:8080/jdbcjspservlate/
```

Or directly to students list:
```
http://localhost:8080/jdbcjspservlate/student?action=list
```

## 📁 Project Structure

```
jdbcjspservlate/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/jdbcjspservlate/
│   │   │       ├── DBConnection.java          # Database connection utility
│   │   │       ├── Student.java               # Student model class
│   │   │       ├── StudentDAO.java            # CRUD operations
│   │   │       ├── StudentServlet.java        # Web servlet
│   │   │       ├── PreventSQLInjection.java   # SQL Injection demo
│   │   │       └── TransactionManagement.java # Transaction demo
│   │   ├── resources/
│   │   └── webapp/
│   │       ├── index.jsp                      # Home page
│   │       ├── students.jsp                   # Student list
│   │       ├── student-form.jsp               # Add/Edit form
│   │       ├── student-detail.jsp             # Student details
│   │       └── WEB-INF/
│   │           └── web.xml                    # Web configuration
│   └── test/
├── database-setup.sql                         # Database initialization
├── pom.xml                                    # Maven configuration
└── README.md                                  # This file
```

## 🔧 Key Java Classes

### 1. DBConnection.java
Manages MySQL database connections:
```java
Connection con = DBConnection.getConnection();
```

### 2. Student.java
Model class representing a student:
```java
Student student = new Student(name, age, email);
```

### 3. StudentDAO.java
Data Access Object with CRUD operations:
```java
StudentDAO.insertStudent(student);
StudentDAO.getAllStudents();
StudentDAO.updateStudent(id, name, age, email);
StudentDAO.deleteStudent(id);
```

### 4. StudentServlet.java
Handles HTTP requests:
```
GET  /student?action=list     → List all students
GET  /student?action=view&id=X → View student
GET  /student?action=edit&id=X → Edit form
POST /student?action=add      → Add new student
POST /student?action=update   → Update student
GET  /student?action=delete&id=X → Delete student
```

## 📊 Database Schema

### Students Table
```sql
CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## 🛡️ Security Features

### SQL Injection Prevention
The application uses **PreparedStatement** for all database queries:

**❌ Vulnerable (NOT used):**
```java
String sql = "SELECT * FROM students WHERE name = '" + userInput + "'";
```

**✅ Secure (Used throughout):**
```java
String sql = "SELECT * FROM students WHERE name = ?";
PreparedStatement ps = con.prepareStatement(sql);
ps.setString(1, userInput);
```

### Transaction Management
Implements ACID properties with commit/rollback:

```java
con.setAutoCommit(false);  // Start transaction
try {
    // Database operations
    con.commit();           // Save changes
} catch (Exception e) {
    con.rollback();         // Revert changes
}
```

## 🔍 API Endpoints

### List Students
```
GET http://localhost:8080/jdbcjspservlate/student?action=list
```

### View Student
```
GET http://localhost:8080/jdbcjspservlate/student?action=view&id=1
```

### Add Student (Form)
```
GET http://localhost:8080/jdbcjspservlate/student-form.jsp
POST http://localhost:8080/jdbcjspservlate/student?action=add
```

### Edit Student
```
GET http://localhost:8080/jdbcjspservlate/student?action=edit&id=1
POST http://localhost:8080/jdbcjspservlate/student?action=update
```

### Delete Student
```
GET http://localhost:8080/jdbcjspservlate/student?action=delete&id=1
```

## 🧪 Testing

### Manual Testing Checklist

- [ ] Create a new student
- [ ] View student list
- [ ] View individual student details
- [ ] Edit student information
- [ ] Delete student record
- [ ] Test SQL injection prevention (try: `' OR '1'='1` in input fields)
- [ ] Verify responsive design on mobile

### Sample Test Data

```
Student 1: Abhra, Age: 22, Email: abhra@example.com
Student 2: Bca, Age: 25, Email: bca@example.com
Student 3: Claude, Age: 21, Email: claude@example.com
```

## 📦 Dependencies

```xml
<dependency>
    <groupId>jakarta.servlet</groupId>
    <artifactId>jakarta.servlet-api</artifactId>
    <version>6.1.0</version>
</dependency>
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.33</version>
</dependency>
```

## 🐛 Troubleshooting

### Connection Error: "No suitable driver found"
- Ensure MySQL JDBC driver is in classpath
- Check `pom.xml` for mysql-connector-java dependency
- Run `mvn clean install`

### Connection Error: "Access denied for user 'root'"
- Verify MySQL password in `DBConnection.java`
- Ensure MySQL server is running
- Check user permissions

### 404 Error: "Cannot find servlet"
- Verify servlet mapping in `web.xml`
- Check URL spelling
- Rebuild and redeploy application

### Table Not Found Error
- Run `database-setup.sql` to create tables
- Verify database name is `studentdb`
- Check working database by running `SHOW TABLES;` in MySQL

## 📝 Example Usage

### Adding a Student via Java
```java
Student student = new Student("John Doe", 20, "john@example.com");
boolean success = StudentDAO.insertStudent(student);
if (success) {
    System.out.println("Student added successfully!");
}
```

### Fetching All Students
```java
List<Student> students = StudentDAO.getAllStudents();
for (Student student : students) {
    System.out.println(student);
}
```

### Updating a Student
```java
boolean success = StudentDAO.updateStudent(1, "Jane Doe", 21, "jane@example.com");
```

### Deleting a Student
```java
boolean success = StudentDAO.deleteStudent(1);
```

## 🎓 Educational Value

This project demonstrates:
1. **JDBC Fundamentals** - Connection, Statement, ResultSet
2. **Servlet Programming** - Request handling, response generation
3. **JSP Pages** - Dynamic content generation
4. **MVC Pattern** - Separation of concerns
5. **Security Best Practices** - SQL injection prevention
6. **Database Transactions** - Commit/Rollback operations
7. **Error Handling** - Try-catch-finally patterns
8. **UI/UX Design** - Modern responsive interfaces

## 📚 Additional Resources

See `setup.md` for detailed documentation on:
- CRUD Operations Using JDBC
- PreparedStatement to Prevent SQL Injection
- Transaction Management (Commit & Rollback)

## 🤝 Contributing

Feel free to fork this project and enhance it with:
- Unit tests using JUnit
- Input validation framework
- Database connection pooling
- Logging framework (SLF4J, Log4j)
- Authentication and authorization

## 📄 License

This project is open source and available under the MIT License.

## 👤 Author

Created as a comprehensive learning resource for JDBC, JSP, and Servlet integration.

---

**Happy Coding! 🚀**


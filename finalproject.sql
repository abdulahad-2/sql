-- Create Database
CREATE DATABASE AttendanceSystem;
USE AttendanceSystem;

-- Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    roll_no VARCHAR(20) UNIQUE,
    class VARCHAR(50),
    department VARCHAR(50)
);

-- Teachers Table
CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    subject VARCHAR(50),
    department VARCHAR(50)
);

-- Courses Table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

-- Attendance Table
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    date DATE,
    status ENUM('Present', 'Absent', 'Late'),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert Students
INSERT INTO Students (name, roll_no, class, department) VALUES
('Amit Kumar', 'CS101', 'CS-1st Year', 'Computer Science'),
('Priya Sharma', 'CS102', 'CS-1st Year', 'Computer Science'),
('Rahul Verma', 'EE201', 'EE-2nd Year', 'Electrical');

-- Insert Teachers
INSERT INTO Teachers (name, subject, department) VALUES
('Dr. Meena Singh', 'DBMS', 'Computer Science'),
('Prof. Arjun Rao', 'Circuits', 'Electrical');

-- Insert Courses
INSERT INTO Courses (course_name, teacher_id) VALUES
('Database Management System', 1),
('Electrical Circuits', 2);

-- Insert Attendance Records
INSERT INTO Attendance (student_id, course_id, date, status) VALUES
(1, 1, '2025-08-01', 'Present'),
(2, 1, '2025-08-01', 'Absent'),
(3, 2, '2025-08-01', 'Late'),
(1, 1, '2025-08-02', 'Absent'),
(2, 1, '2025-08-02', 'Present'),
(3, 2, '2025-08-02', 'Present');

-- Show all attendance records
SELECT s.name, s.roll_no, c.course_name, a.date, a.status
FROM Attendance a
JOIN Students s ON a.student_id = s.student_id
JOIN Courses c ON a.course_id = c.course_id;

-- Count Present/Absent per Student
SELECT s.name,
       SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS Total_Present,
       SUM(CASE WHEN a.status = 'Absent' THEN 1 ELSE 0 END) AS Total_Absent
FROM Attendance a
JOIN Students s ON a.student_id = s.student_id
GROUP BY s.name;

-- Attendance Percentage
SELECT s.name,
       ROUND((SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),2) AS Attendance_Percentage
FROM Attendance a
JOIN Students s ON a.student_id = s.student_id
GROUP BY s.name;

-- Students absent more than once
SELECT s.name, COUNT(*) AS Absent_Count
FROM Attendance a
JOIN Students s ON a.student_id = s.student_id
WHERE a.status = 'Absent'
GROUP BY s.name
HAVING COUNT(*) > 1;

-- Students with their Teachers
SELECT s.name AS Student, t.name AS Teacher, c.course_name
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id
JOIN Courses c ON a.course_id = c.course_id
JOIN Teachers t ON c.teacher_id = t.teacher_id;

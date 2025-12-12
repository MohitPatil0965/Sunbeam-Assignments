/*Creating Database internship*/
show databases;
create database internship;
use internship;

/*Creating tables users, courses, student, videos*/

CREATE TABLE users (
    ->user_id INT PRIMARY KEY AUTO_INCREMENT,
    ->email VARCHAR(50) UNIQUE,
    ->password INT,
    ->role ENUM('admin', 'student')
    ->);

 desc users;
+----------+-------------------------+------+-----+---------+----------------+
| Field    | Type                    | Null | Key | Default | Extra          |
+----------+-------------------------+------+-----+---------+----------------+
| user_id  | int                     | NO   | PRI | NULL    | auto_increment |
| email    | varchar(50)             | YES  | UNI | NULL    |                |
| password | int                     | YES  |     | NULL    |                |
| role     | enum('admin','student') | YES  |     | NULL    |                |
+----------+-------------------------+------+-----+---------+----------------+

CREATE TABLE courses (
    ->course_id INT PRIMARY KEY AUTO_INCREMENT,
    ->course_name VARCHAR(50),
    ->description VARCHAR(100),
    ->fees INT,
    ->start_date DATE,
    ->end_date DATE,
    ->video_expiry_days INT
    ->);

desc courses;
+-------------------+--------------+------+-----+---------+----------------+
| Field             | Type         | Null | Key | Default | Extra          |
+-------------------+--------------+------+-----+---------+----------------+
| course_id         | int          | NO   | PRI | NULL    | auto_increment |
| course_name       | varchar(50)  | YES  |     | NULL    |                |
| description       | varchar(100) | YES  |     | NULL    |                |
| fees              | int          | YES  |     | NULL    |                |
| start_date        | date         | YES  |     | NULL    |                |
| end_date          | date         | YES  |     | NULL    |                |
| video_expiry_days | int          | YES  |     | NULL    |                |
+-------------------+--------------+------+-----+---------+----------------+

 CREATE TABLE students (
    ->reg_no INT PRIMARY KEY AUTO_INCREMENT,
    ->name VARCHAR(50),
    ->email VARCHAR(50),
    ->course_id INT,
    ->mobile_no BIGINT,
    ->profile_pic BLOB,
    ->FOREIGN KEY (course_id) REFERENCES courses(course_id)
    ->);

desc students;
+-------------+-------------+------+-----+---------+----------------+
| Field       | Type        | Null | Key | Default | Extra          |
+-------------+-------------+------+-----+---------+----------------+
| reg_no      | int         | NO   | PRI | NULL    | auto_increment |
| name        | varchar(50) | YES  |     | NULL    |                |
| email       | varchar(50) | YES  |     | NULL    |                |
| course_id   | int         | YES  | MUL | NULL    |                |
| mobile_no   | bigint      | YES  |     | NULL    |                |
| profile_pic | blob        | YES  |     | NULL    |                |
+-------------+-------------+------+-----+---------+----------------+

 CREATE TABLE videos (
    ->video_id INT PRIMARY KEY AUTO_INCREMENT,
    ->course_id INT,
    ->title VARCHAR(50),
    ->description VARCHAR(150),
    ->youtube_url VARCHAR(100),
    ->added_at DATE,
    ->FOREIGN KEY (course_id) REFERENCES courses(course_id)
    ->);

desc videos;
+-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| video_id    | int          | NO   | PRI | NULL    | auto_increment |
| course_id   | int          | YES  | MUL | NULL    |                |
| title       | varchar(50)  | YES  |     | NULL    |                |
| description | varchar(150) | YES  |     | NULL    |                |
| youtube_url | varchar(100) | YES  |     | NULL    |                |
| added_at    | date         | YES  |     | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+

/*Adding values in all tables*/

INSERT INTO courses (course_id, course_name, description, fees, start_date, end_date, video_expiry_days)
    ->VALUES
    ->(2, 'AI', 'Course related to AI', '10000', '2025-12-24' , '2026-1-24', 5),
    ->(3, 'Android', 'Android related course', '9000', '2025-12-24' , '2026-1-24', 7),
    ->(4, 'Python', 'Python related course', '9000', '2025-12-24' , '2026-1-24', 20);

INSERT INTO students (reg_no, name, email, mobile_no, course_id)
    ->VALUES
    ->(1, 'student1', 's1', 123456, 1),
    ->(3, 'student3', 's3', 123456, 1),
    ->(6, 'student2', 's2', 123456, 3);

INSERT INTO videos (video_id, course_id, title, description, youtube_url, added_at)
    ->VALUES
    ->(12, 1, 'MERN video 6', 'desc', '#', '2025-11-26 23:36:18'),
    ->(14, 1, 'MERN 10', 'desc', '#', '2025-11-26 23:52:13');

INSERT INTO users (email, password, role)
    ->VALUES
    ->('admin1@gmail.com','1234','admin'),
    ->('admin1@gmail.com','1234','admin'),
    ->('student1@gmail.com','1234','student'),
    ->('student2@gmail.com','1234','student');

/* Q1 Write a SQL query that will fetch all upcoming courses. */

SELECT *
    ->FROM courses
    ->WHERE start_date > CURDATE();

+-----------+-------------+------------------------+-------+------------+------------+-------------------+
| course_id | course_name | description            | fees  | start_date | end_date   | video_expiry_days |
+-----------+-------------+------------------------+-------+------------+------------+-------------------+
|         1 | IIT-MERN    | MERN                   |  4000 | 2025-12-20 | 2026-01-20 |                30 |
|         2 | AI          | Course related to AI   | 10000 | 2025-12-24 | 2026-01-24 |                 5 |
|         3 | Android     | Android related course |  9000 | 2025-12-24 | 2026-01-24 |                 7 |
|         4 | Python      | Python related course  |  9000 | 2025-12-24 | 2026-01-24 |                20 |
+-----------+-------------+------------------------+-------+------------+------------+-------------------+


/* Q2 Write SQL query that will fetch all the registered students along with course name */

 SELECT
    ->s.reg_no,
    ->s.name,
    ->s.email,
    ->s.mobile_no,
    ->s.course_id,
    ->c.course_name
    ->FROM students s
    ->JOIN courses c ON s.course_id = c.course_id;

+--------+----------+-------+-----------+-----------+-------------+
| reg_no | name     | email | mobile_no | course_id | course_name |
+--------+----------+-------+-----------+-----------+-------------+
|      1 | student1 | s1    |    123456 |         1 | IIT-MERN    |
|      3 | student3 | s3    |    123456 |         1 | IIT-MERN    |
|      6 | student2 | s2    |    123456 |         3 | Android     |
+--------+----------+-------+-----------+-----------+-------------+

/* Q3 Write an SQL query to fetch the complete details of a student (based on their emails) along with 
details of the course they are enrolled in */

 SELECT
    ->s.reg_no,
    ->s.name,
    ->s.email,
    ->s.mobile_no,
    ->s.course_id,
    ->c.course_name,
    ->c.description,
    ->c.fees,
    ->c.start_date,
    ->c.end_date,
    ->c.video_expiry_days
    -> FROM students s
    -> JOIN courses c ON s.course_id = c.course_id
    -> WHERE s.email = 's1';
+--------+----------+-------+-----------+-----------+-------------+-------------+------+------------+------------+-------------------+
| reg_no | name     | email | mobile_no | course_id | course_name | description | fees | start_date | end_date   | video_expiry_days |
+--------+----------+-------+-----------+-----------+-------------+-------------+------+------------+------------+-------------------+
|      1 | student1 | s1    |    123456 |         1 | IIT-MERN    | MERN        | 4000 | 2025-12-20 | 2026-01-20 |                30 |
+--------+----------+-------+-----------+-----------+-------------+-------------+------+------------+------------+-------------------+

/* Q4 Write an SQL query to retrieve the course details and the list of non-expired videos for a specific student
using their email address. A video is considered active if its added at date plus the course
video_expiry_days has not yet passed compare to the current date */

SELECT
    ->c.course_id,
    ->c.course_name,
    ->c.start_date,
    ->c.end_date,
    ->c.video_expiry_days,
    ->v.video_id,
    ->v.title,
    ->v.added_at
    -> FROM students s
    -> JOIN courses c ON s.course_id = c.course_id
    -> JOIN videos v ON c.course_id = v.course_id
    -> WHERE s.email = 's1'
    ->   AND DATE_ADD(v.added_at, INTERVAL c.video_expiry_days DAY) >= CURDATE();
+-----------+-------------+------------+------------+-------------------+----------+--------------+------------+
| course_id | course_name | start_date | end_date   | video_expiry_days | video_id | title        | added_at   |
+-----------+-------------+------------+------------+-------------------+----------+--------------+------------+
|         1 | IIT-MERN    | 2025-12-20 | 2026-01-20 |                30 |       12 | MERN video 6 | 2025-11-26 |
|         1 | IIT-MERN    | 2025-12-20 | 2026-01-20 |                30 |       14 | MERN 10      | 2025-11-26 |
+-----------+-------------+------------+------------+-------------------+----------+--------------+------------+
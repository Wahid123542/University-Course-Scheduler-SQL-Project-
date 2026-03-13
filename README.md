University-course-scheduler- SQL-Project

This repository contains the SQL script and log file for CSCE 55203 project, a project assigned by my instructor at the University of Arkansas. The homework implements a University Class Scheduling System using MariaDB/MySQL.

Project Overview

This project models a simplified university course scheduling environment, including:

Departments (DEPT)

Professors (PROFESSOR)

Courses (COURSE)

Rooms (ROOM)

Course Sections (SECTION)

The system enforces relationships between tables using primary keys and foreign keys, and supports queries to manage scheduling data.

Features

Drop existing tables to start with a clean slate

Create tables with constraints (PRIMARY KEY, FOREIGN KEY, CHECK)

Insert sample records for departments, professors, courses, rooms, and sections

Perform queries to:

List tables and describe their structure

Find rooms with the lowest capacity

Identify open CSCE electives

Calculate total enrollment per professor

Find professors teaching only in their home department building

Insert and update specific course sections

Demonstrate cascading and restriction behaviors in the database

Files

a3.sql – SQL script containing all commands to create, populate, and query the database

a3.log – Output log showing commands executed and results

Usage

Start MariaDB/MySQL and select your database:

USE wsultani;

Run the SQL script or paste its commands:

source a3.sql;

View the output log in a3.log to see the results of all operations.

Example Queries

Show all sections taught by a specific professor:

SELECT s.* 
FROM SECTION s
JOIN PROFESSOR p ON s.PROF_ID = p.PROF_ID
WHERE p.PROF_NAME = 'Brajendra Panda';

Find open CSCE electives:

SELECT s.COURSE_NUM, s.DEPT_CODE, (s.MAX_ENROLLMENT - s.CURRENT_ENROLLMENT) AS SEATS_AVAILABLE
FROM SECTION s
JOIN COURSE c ON s.DEPT_CODE = c.DEPT_CODE AND s.COURSE_NUM = c.COURSE_NUM
WHERE s.DEPT_CODE = 'CSCE' AND s.COURSE_NUM >= '4000' AND c.CREDIT >= 3 AND s.CURRENT_ENROLLMENT < s.MAX_ENROLLMENT;

Update course enrollment:

UPDATE SECTION
SET CURRENT_ENROLLMENT = 100
WHERE DEPT_CODE = 'CSCE' AND COURSE_NUM = '2004';
Notes

Project assigned by my instructor for CSCE 55203

Designed and tested on MariaDB 10.x at turing.csce.uark.edu

Demonstrates practical use of relational database concepts, including normalization, foreign keys, and data integrity

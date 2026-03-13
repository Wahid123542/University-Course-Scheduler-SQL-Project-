# University Class Scheduling System
### CSCE 55203 – Database Systems | University of Arkansas

A relational database implementation of a university class scheduling system, built with **MariaDB/MySQL** and tested on the university's `turing.csce.uark.edu` server.

---

## Overview

This project models a simplified university course scheduling environment using a normalized relational schema. It demonstrates practical database concepts including entity integrity, referential integrity, cascading deletes, and complex SQL queries.

The schema consists of five related tables:

| Table | Description |
|-------|-------------|
| `DEPT` | Academic departments and their home buildings |
| `PROFESSOR` | Faculty members and their department affiliations |
| `COURSE` | Course catalog with credit hours |
| `ROOM` | Campus rooms with capacity and type |
| `SECTION` | Course sections linking professors, rooms, and enrollment data |

---

## Files

| File | Description |
|------|-------------|
| `a3.sql` | Full SQL script — creates tables, inserts data, and runs all queries |
| `a3.log` | Terminal output log showing all commands and their results |

---

## Setup & Usage

**Prerequisites:** Access to a MariaDB/MySQL server.

**1. Connect and select your database:**
```sql
mysql -u your_username -p
USE your_database_name;
```

**2. Enable logging (optional):**
```sql
tee a3.log;
```

**3. Run the script:**
```sql
source a3.sql;
```

**4. Stop logging:**
```sql
notee;
```

---

## Schema Design

Foreign key constraints are defined as follows:

- **RESTRICT** – Deleting a `DEPT` row is blocked if `COURSE` rows reference it
- **CASCADE** – Deleting a `PROFESSOR` cascades and removes all their `SECTION` rows

This ensures referential integrity while allowing flexible management of professors and sections.

---

## Example Queries

**Find the room with the lowest capacity:**
```sql
SELECT BUILDING, ROOM_NUM, CAPACITY
FROM ROOM
WHERE CAPACITY = (SELECT MIN(CAPACITY) FROM ROOM);
```

**Find open CSCE electives (≥4000 level, ≥3 credits, seats available):**
```sql
SELECT s.COURSE_NUM, s.DEPT_CODE,
       (s.MAX_ENROLLMENT - s.CURRENT_ENROLLMENT) AS SEATS_AVAILABLE
FROM SECTION s
JOIN COURSE c ON s.DEPT_CODE = c.DEPT_CODE AND s.COURSE_NUM = c.COURSE_NUM
WHERE s.DEPT_CODE = 'CSCE'
  AND s.COURSE_NUM >= '4000'
  AND c.CREDIT >= 3
  AND s.CURRENT_ENROLLMENT < s.MAX_ENROLLMENT;
```

**Show total max enrollment per professor:**
```sql
SELECT p.PROF_NAME, SUM(s.MAX_ENROLLMENT) AS TOTAL_MAX_ENROLLMENT
FROM PROFESSOR p
JOIN SECTION s ON p.PROF_ID = s.PROF_ID
GROUP BY p.PROF_ID, p.PROF_NAME;
```

**Show all sections taught by a specific professor:**
```sql
SELECT s.*
FROM SECTION s
JOIN PROFESSOR p ON s.PROF_ID = p.PROF_ID
WHERE p.PROF_NAME = 'Brajendra Panda';
```

**Demonstrate cascade delete — drop a professor and their sections:**
```sql
DELETE FROM PROFESSOR WHERE PROF_NAME = 'Alexander Nelson';
```

---

## Concepts Demonstrated

- Relational schema design and normalization
- Primary keys, composite keys, and foreign keys
- `CHECK` constraints for domain integrity
- `ON DELETE CASCADE` and `ON DELETE RESTRICT` behaviors
- Aggregate queries with `GROUP BY`
- Subqueries and multi-table `JOIN`s
- `INSERT`, `UPDATE`, and `DELETE` operations

---

## Environment

- **Database:** MariaDB 10.x
- **Server:** `turing.csce.uark.edu` (University of Arkansas)
- **Course:** CSCE 55203 – Database Systems


-- ============================================================
-- TASK 0: Drop existing tables (clean slate)
-- ============================================================
DROP TABLE IF EXISTS SECTION;
DROP TABLE IF EXISTS PROFESSOR;
DROP TABLE IF EXISTS COURSE;
DROP TABLE IF EXISTS ROOM;
DROP TABLE IF EXISTS DEPT;

-- ============================================================
-- TASK 1: Create Tables
-- ============================================================

CREATE TABLE DEPT (
    DEPT_CODE   CHAR(4)         NOT NULL,
    DEPT_NAME   VARCHAR(50)     NOT NULL,
    ROOM_NUM    INT             NOT NULL,
    BUILDING    VARCHAR(50)     NOT NULL,
    PRIMARY KEY (DEPT_CODE)
);

CREATE TABLE PROFESSOR (
    PROF_ID     INT             NOT NULL,
    PROF_NAME   VARCHAR(50)     NOT NULL,
    RANK_TITLE  VARCHAR(30),
    DEPT_CODE   CHAR(4)         NOT NULL,
    EMAIL       VARCHAR(50)     NOT NULL,
    PRIMARY KEY (PROF_ID),
    FOREIGN KEY (DEPT_CODE) REFERENCES DEPT(DEPT_CODE)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE COURSE (
    DEPT_CODE   CHAR(4)         NOT NULL,
    COURSE_NUM  VARCHAR(5)      NOT NULL,
    COURSE_NAME VARCHAR(50)     NOT NULL,
    CREDIT      INT             NOT NULL CHECK (CREDIT BETWEEN 1 AND 6),
    PRIMARY KEY (DEPT_CODE, COURSE_NUM),
    FOREIGN KEY (DEPT_CODE) REFERENCES DEPT(DEPT_CODE)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE ROOM (
    ROOM_NUM    INT             NOT NULL,
    BUILDING    VARCHAR(50)     NOT NULL,
    CAPACITY    INT             CHECK (CAPACITY > 0),
    ROOM_TYPE   VARCHAR(15),
    PRIMARY KEY (ROOM_NUM, BUILDING)
);

CREATE TABLE SECTION (
    SID                 INT             NOT NULL,
    DEPT_CODE           CHAR(4),
    COURSE_NUM          VARCHAR(5),
    PROF_ID             INT,
    ROOM_NUM            INT,
    BUILDING            VARCHAR(50),
    DAYS                VARCHAR(7),
    START               TIME,
    END                 TIME,
    START_DAY           DATE            NOT NULL,
    END_DAY             DATE            NOT NULL,
    MAX_ENROLLMENT      INT             CHECK (MAX_ENROLLMENT >= 0),
    CURRENT_ENROLLMENT  INT             DEFAULT 0,
    PRIMARY KEY (SID),
    FOREIGN KEY (DEPT_CODE, COURSE_NUM) REFERENCES COURSE(DEPT_CODE, COURSE_NUM)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (PROF_ID) REFERENCES PROFESSOR(PROF_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (ROOM_NUM, BUILDING) REFERENCES ROOM(ROOM_NUM, BUILDING)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================
-- TASK 2: Describe Tables
-- ============================================================
DESC DEPT;
DESC PROFESSOR;
DESC COURSE;
DESC ROOM;
DESC SECTION;

-- ============================================================
-- TASK 3: Insert Records
-- ============================================================

-- DEPT
INSERT INTO DEPT VALUES ('CSCE', 'Computer Science & Computer Engineering', 504,  'JBHT');
INSERT INTO DEPT VALUES ('ELEG', 'Electrical Engineering',                  3217, 'BELL');
INSERT INTO DEPT VALUES ('MEEG', 'Mechanical Engineering',                  204,  'MEEG');

-- PROFESSOR
INSERT INTO PROFESSOR VALUES (123456, 'Susan Gauch',      'Professor',               'CSCE', 'sgauch@uark.edu');
INSERT INTO PROFESSOR VALUES (123457, 'John Gauch',       'Professor',               'CSCE', 'jgauch@uark.edu');
INSERT INTO PROFESSOR VALUES (222222, 'Yanjun Pan',       'Assistant Professor',     'CSCE', 'yanjunp@uark.edu');
INSERT INTO PROFESSOR VALUES (317778, 'Alan Mantooth',    'Distinguished Professor', 'ELEG', 'mantooth@uark.edu');
INSERT INTO PROFESSOR VALUES (310101, 'Brajendra Panda',  'Professor',               'CSCE', 'bpanda@uark.edu');
INSERT INTO PROFESSOR VALUES (444555, 'Alexander Nelson', 'Associate Professor',     'CSCE', 'ahnelson@uark.edu');
INSERT INTO PROFESSOR VALUES (555110, 'Kevin Jin',        'Associate Professor',     'CSCE', 'dongjin@uark.edu');

-- COURSE
INSERT INTO COURSE VALUES ('CSCE', '2004',  'Programming Foundations I',      3);
INSERT INTO COURSE VALUES ('CSCE', '2114',  'Programming Foundations II',     3);
INSERT INTO COURSE VALUES ('CSCE', '3193',  'Programming Paradigms',          3);
INSERT INTO COURSE VALUES ('CSCE', '3193H', 'Honors Programming Paradigms',   3);
INSERT INTO COURSE VALUES ('CSCE', '4553',  'Information Retrieval Lab',      2);
INSERT INTO COURSE VALUES ('CSCE', '4263',  'Mobile Programming',             3);
INSERT INTO COURSE VALUES ('CSCE', '4623',  'Advanced Data Structures',       3);
INSERT INTO COURSE VALUES ('ELEG', '4188',  'Power Electronics',              3);
INSERT INTO COURSE VALUES ('CSCE', '4963',  'Capstone II',                    3);
INSERT INTO COURSE VALUES ('CSCE', '5533',  'Advanced Information Retrieval', 3);
INSERT INTO COURSE VALUES ('CSCE', '4988',  'Embedded Systems Lab',           2);

-- ROOM
INSERT INTO ROOM VALUES (239,  'JBHT', 36,  'Lab');
INSERT INTO ROOM VALUES (236,  'JBHT', 45,  'Lab');
INSERT INTO ROOM VALUES (147,  'JBHT', 140, 'Classroom');
INSERT INTO ROOM VALUES (216,  'JBHT', 170, 'Classroom');
INSERT INTO ROOM VALUES (2269, 'BELL', 70,  'Conference');
INSERT INTO ROOM VALUES (2286, 'BELL', 100, 'Classroom');
INSERT INTO ROOM VALUES (225,  'MEEG', 70,  'Classroom');

-- SECTION
INSERT INTO SECTION VALUES (9597,  'CSCE','2004',  222222, 2269, 'BELL', 'MWF', '15:05','15:55','2023-08-21','2023-12-07', 70,  0);
INSERT INTO SECTION VALUES (1449,  'CSCE','2114',  123457, 216,  'JBHT', 'MWF', '12:55','13:45','2023-08-21','2023-12-07', 138, 0);
INSERT INTO SECTION VALUES (2930,  'CSCE','3193',  222222, 216,  'JBHT', 'TR',  '15:30','16:45','2023-08-21','2023-12-07', 140, 0);
INSERT INTO SECTION VALUES (4636,  'CSCE','3193H', 222222, 216,  'JBHT', 'TR',  '15:30','16:45','2023-08-21','2023-12-07', 30,  0);
INSERT INTO SECTION VALUES (12550, 'CSCE','4553',  123456, 239,  'JBHT', 'MWF', '9:40', '10:30','2023-08-21','2023-12-07', 30,  0);
INSERT INTO SECTION VALUES (11957, 'CSCE','4263',  555110, 239,  'JBHT', 'TR',  '8:00', '9:15', '2023-08-21','2023-12-07', 0,   0);
INSERT INTO SECTION VALUES (6704,  'CSCE','4623',  444555, 2286, 'BELL', 'MWF', '10:45','11:35','2023-08-21','2023-12-07', 65,  0);
INSERT INTO SECTION VALUES (6325,  'CSCE','4963',  444555, 147,  'JBHT', 'MWF', '15:05','15:55','2023-08-21','2023-12-07', 50,  0);
INSERT INTO SECTION VALUES (11944, 'CSCE','5533',  123456, 239,  'JBHT', 'MWF', '15:05','15:55','2023-08-21','2023-12-07', 30,  0);

-- ============================================================
-- TASK 4: Show filled tables
-- ============================================================
SELECT * FROM DEPT;
SELECT * FROM PROFESSOR;
SELECT * FROM COURSE;
SELECT * FROM ROOM;
SELECT * FROM SECTION;

-- ============================================================
-- TASK 5: Room(s) with the lowest capacity
-- ============================================================
SELECT BUILDING, ROOM_NUM, CAPACITY
FROM ROOM
WHERE CAPACITY = (SELECT MIN(CAPACITY) FROM ROOM);

-- ============================================================
-- TASK 6a: Open CSCE electives (COURSE_NUM >= 4000, >= 3 credits,
--          CURRENT_ENROLLMENT < MAX_ENROLLMENT)
-- ============================================================
SELECT s.COURSE_NUM, s.DEPT_CODE,
       (s.MAX_ENROLLMENT - s.CURRENT_ENROLLMENT) AS SEATS_AVAILABLE
FROM SECTION s
JOIN COURSE c ON s.DEPT_CODE = c.DEPT_CODE AND s.COURSE_NUM = c.COURSE_NUM
WHERE s.DEPT_CODE = 'CSCE'
  AND s.COURSE_NUM >= '4000'
  AND c.CREDIT >= 3
  AND s.CURRENT_ENROLLMENT < s.MAX_ENROLLMENT;

-- ============================================================
-- TASK 6b: Total MAX_ENROLLMENT per professor
-- ============================================================
SELECT p.PROF_NAME, SUM(s.MAX_ENROLLMENT) AS TOTAL_MAX_ENROLLMENT
FROM PROFESSOR p
JOIN SECTION s ON p.PROF_ID = s.PROF_ID
GROUP BY p.PROF_ID, p.PROF_NAME;

-- ============================================================
-- TASK 7: Associate Professors and Professors who teach
--         at least one section AND every section in their
--         dept's home building
-- ============================================================
SELECT p.PROF_NAME, p.RANK_TITLE AS PROF_RANK, d.DEPT_NAME, d.BUILDING AS DEPT_BUILDING
FROM PROFESSOR p
JOIN DEPT d ON p.DEPT_CODE = d.DEPT_CODE
WHERE p.RANK_TITLE IN ('Professor', 'Associate Professor', 'Distinguished Professor')
  AND p.PROF_ID IN (SELECT PROF_ID FROM SECTION)
  AND p.PROF_ID NOT IN (
        SELECT s.PROF_ID
        FROM SECTION s
        JOIN PROFESSOR p2 ON s.PROF_ID = p2.PROF_ID
        JOIN DEPT d2 ON p2.DEPT_CODE = d2.DEPT_CODE
        WHERE s.BUILDING <> d2.BUILDING
      );

-- ============================================================
-- TASK 9: Insert CSCE 4013 Computer Forensics taught by
--         Brajendra Panda in JBHT 239
-- ============================================================
INSERT IGNORE INTO COURSE VALUES ('CSCE', '4013', 'Computer Forensics', 3);

INSERT INTO SECTION (SID, DEPT_CODE, COURSE_NUM, PROF_ID, ROOM_NUM, BUILDING,
                     DAYS, START, END, START_DAY, END_DAY, MAX_ENROLLMENT, CURRENT_ENROLLMENT)
VALUES (99999, 'CSCE', '4013', 310101, 239, 'JBHT',
        NULL, NULL, NULL, '2023-08-21', '2023-12-07', 25, 0);

-- Show all sections taught by Brajendra Panda
SELECT s.*
FROM SECTION s
JOIN PROFESSOR p ON s.PROF_ID = p.PROF_ID
WHERE p.PROF_NAME = 'Brajendra Panda';

-- ============================================================
-- TASK 10: Update CSCE 2004 current enrollment to 100
-- ============================================================
UPDATE SECTION
SET CURRENT_ENROLLMENT = 100
WHERE DEPT_CODE = 'CSCE' AND COURSE_NUM = '2004';

SELECT * FROM SECTION WHERE DEPT_CODE = 'CSCE' AND COURSE_NUM = '2004';

-- ============================================================
-- TASK 11: 4000-level CSCE courses BEFORE dropping Nelson
-- ============================================================
SELECT s.COURSE_NUM, c.COURSE_NAME, p.PROF_NAME
FROM SECTION s
JOIN COURSE c    ON s.DEPT_CODE = c.DEPT_CODE AND s.COURSE_NUM = c.COURSE_NUM
JOIN PROFESSOR p ON s.PROF_ID = p.PROF_ID
WHERE s.DEPT_CODE = 'CSCE'
  AND s.COURSE_NUM LIKE '4%';

-- Drop Alexander Nelson (cascades to his SECTION rows)
DELETE FROM PROFESSOR WHERE PROF_NAME = 'Alexander Nelson';

-- 4000-level CSCE courses AFTER dropping Nelson
SELECT s.COURSE_NUM, c.COURSE_NAME, p.PROF_NAME
FROM SECTION s
JOIN COURSE c    ON s.DEPT_CODE = c.DEPT_CODE AND s.COURSE_NUM = c.COURSE_NUM
JOIN PROFESSOR p ON s.PROF_ID = p.PROF_ID
WHERE s.DEPT_CODE = 'CSCE'
  AND s.COURSE_NUM LIKE '4%';
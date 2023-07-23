--CREATE DATABASE school
--use school

CREATE TABLE Groups (
    Id INT PRIMARY KEY IDENTITY(1,1),
    No INT NOT NULL
);

CREATE TABLE Students (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Fullname VARCHAR(50) NOT NULL,
    Point DECIMAL(5, 2) NOT NULL,
    GroupId INT NOT NULL,
    FOREIGN KEY (GroupId) REFERENCES Groups(Id)
);

CREATE TABLE Exams (
    Id INT PRIMARY KEY IDENTITY(1,1),
    SubjectName VARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL
);

CREATE TABLE StudentExams (
    StudentId INT NOT NULL,
    ExamId INT NOT NULL,
    ResultPoint DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (StudentId) REFERENCES Students(Id),
    FOREIGN KEY (ExamId) REFERENCES Exams(Id),
    PRIMARY KEY (StudentId, ExamId)
);

INSERT INTO Groups (No) VALUES (101);
INSERT INTO Groups (No) VALUES (102);

INSERT INTO Students (Fullname, Point, GroupId) VALUES ('Ali Memmedov', 85.5, 1);
INSERT INTO Students (Fullname, Point, GroupId) VALUES ('Aysə Hüseynova', 78.2, 2);
INSERT INTO Students (Fullname, Point, GroupId) VALUES ('Vüqar Sadiqov', 92.7, 1);

INSERT INTO Exams (SubjectName, StartDate, EndDate) VALUES ('Riyaziyyat', '2023-07-20', '2023-07-30');
INSERT INTO Exams (SubjectName, StartDate, EndDate) VALUES ('Fizika', '2023-07-21', '2023-07-31');
INSERT INTO Exams (SubjectName, StartDate, EndDate) VALUES ('Kimya', '2023-07-21', '2023-07-31');

INSERT INTO StudentExams (StudentId, ExamId, ResultPoint) VALUES (1, 1, 80.0);
INSERT INTO StudentExams (StudentId, ExamId, ResultPoint) VALUES (1, 2, 88.5);
INSERT INTO StudentExams (StudentId, ExamId, ResultPoint) VALUES (2, 1, 75.2);
INSERT INTO StudentExams (StudentId, ExamId, ResultPoint) VALUES (2, 3, 90.3);
INSERT INTO StudentExams (StudentId, ExamId, ResultPoint) VALUES (3, 1, 95.8);
INSERT INTO StudentExams (StudentId, ExamId, ResultPoint) VALUES (3, 2, 91.0);
INSERT INTO StudentExams (StudentId, ExamId, ResultPoint) VALUES (3, 3, 88.7);

SELECT Students.*, Groups.No
FROM Students
JOIN Groups ON Students.GroupId = Groups.Id;

SELECT Students.*, COUNT(StudentExams.ExamId) AS NumberOfExams
FROM Students
LEFT JOIN StudentExams ON Students.Id = StudentExams.StudentId
GROUP BY Students.Id;

SELECT Exams.*, COUNT(StudentExams.StudentId) AS NumberOfStudents
FROM Exams
LEFT JOIN StudentExams ON Exams.Id = StudentExams.ExamId
WHERE Exams.StartDate = DATEADD(DAY, -1, GETDATE())
GROUP BY Exams.Id, Exams.SubjectName, Exams.StartDate;

SELECT StudentExams.*, Students.Fullname, Groups.No
FROM StudentExams
JOIN Students ON StudentExams.StudentId = Students.Id
JOIN Groups ON Students.GroupId = Groups.Id;

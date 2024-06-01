-- Задание 3.1
SELECT
  Student.full_name AS Full_name,
  Groups.group_name AS Group_name,
  CASE
    WHEN Student.budget = 1 THEN 'Budget'
    ELSE 'Off-budget'
    END AS Budget
FROM
   Student
   JOIN Groups ON Groups.id = Student.group_id
ORDER BY
   Student.full_name;

-- Задание 3.2
SELECT
   Student.full_name AS [Full name],
   Groups.group_name AS [GROUP name],
   Directions_of_study.direction_name AS [Direction name]
FROM
   Student
   JOIN Groups ON Groups.id = Student.group_id
   JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
WHERE
   Student.full_name LIKE 'M%';

-- Задание 3.3
SELECT
   CONCAT (
      LEFT (full_name, CHARINDEX(' ', full_name)),
      LEFT(SUBSTRING(full_name, CHARINDEX(' ', full_name) + 1, LEN(full_name)), 1) + '. ',
      LEFT(SUBSTRING(full_name, CHARINDEX(' ', full_name, CHARINDEX(' ', full_name) + 1) + 1, LEN(full_name)), 1) + '.'
   ) AS name,
   DATEPART(DAY, Student.date_of_birth) AS day,
   CASE
      WHEN DATEPART(MONTH, Student.date_of_birth) = 1 THEN 'January'
      WHEN DATEPART(MONTH, Student.date_of_birth) = 2 THEN 'February'
      WHEN DATEPART(MONTH, Student.date_of_birth) = 3 THEN 'March'
      WHEN DATEPART(MONTH, Student.date_of_birth) = 4 THEN 'April'
      WHEN DATEPART(MONTH, Student.date_of_birth) = 5 THEN 'May'
      WHEN DATEPART(MONTH, Student.date_of_birth) = 6 THEN 'June'
      WHEN DATEPART(MONTH, Student.date_of_birth) = 7 THEN 'July'
      WHEN DATEPART(MONTH, Student.date_of_birth) = 8 THEN 'August'
      WHEN DATEPART(MONTH, Student.date_of_birth) = 9 THEN 'September'
      WHEN DATEPART(MONTH, Student.date_of_birth) = 10 THEN 'October'
      WHEN DATEPART(MONTH, Student.date_of_birth) = 11 THEN 'November'
      ELSE 'December'
   END AS Month,
   Groups.group_name AS Group_name,
   Directions_of_study.direction_name AS Direction_name
FROM
   Student
   JOIN Groups ON Groups.id = Student.group_id
   JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
ORDER BY
   DATEPART(MONTH, Student.date_of_birth);

-- Задание 3.4
SELECT
   full_name,
   (YEAR(GETDATE()) - YEAR(date_of_birth)) AS Age
FROM
   student;

-- Задание 3.5
SELECT
   full_name AS Name,
   date_of_birth AS Birthday
FROM
   Student
WHERE
   MONTH(Student.date_of_birth) = MONTH(GETDATE());

-- Задание 3.6
SELECT
   COUNT (Student.id) AS Students_number,
   Directions_of_study.direction_name AS Direction_name
FROM
   Student
   JOIN Groups ON Groups.id = Student.group_id
   JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
GROUP BY
   Directions_of_study.direction_name;

-- Задание 3.7
SELECT
   Groups.group_name,
   Directions_of_study.direction_name,
   SUM(CASE WHEN Student.budget = 1 THEN 1 ELSE 0 END) AS number_of_budget,
   SUM(CASE WHEN Student.budget = 0 THEN 1 ELSE 0 END) AS number_of_non_budget
FROM
   Student
   JOIN Groups ON Groups.id = Student.group_id
   JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
GROUP BY
   Groups.group_name,
   Directions_of_study.direction_name;

-- Задание 5.1
SELECT
   Disciplines.name,
   Groups.group_name,
   Teachers.name
FROM
   Disciplines
   JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
   JOIN Directions_of_study ON Directions_of_study.id = DirectionDisciplineTeacher.direction_id
   JOIN Groups ON Groups.direction_id = Directions_of_study.id
   JOIN Teachers ON Teachers.id = DirectionDisciplineTeacher.teacher_id

-- Задание 5.2
SELECT TOP 1
   Disciplines.name AS disc_name,
   COUNT(Student.full_name) AS s_num
FROM
   Disciplines
   JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
   JOIN Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
   JOIN Student ON Marks.student_id = Student.id
GROUP BY
   Disciplines.name
ORDER BY
   COUNT(Student.full_name) DESC;

-- Задание 5.3
SELECT
   Teachers.name,
   COUNT (Student.id) AS s_num
FROM
   Teachers
   JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.teacher_id = Teachers.id
   JOIN Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
   JOIN Student ON Student.id = Marks.student_id
GROUP BY
   Teachers.name

-- Задание 5.4
SELECT
   Disciplines.name AS disc_name,
   COUNT (
      CASE
         WHEN Marks.mark > 2 THEN 1
         ELSE 0
      END
   ) AS s_num
FROM
   Disciplines
   JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
   JOIN Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
   JOIN Student ON Marks.student_id = Student.id
GROUP BY
   Disciplines.name
ORDER BY
   COUNT (Student.full_name) DESC

-- Задание 5.5
SELECT
   Disciplines.name AS disc_name,
   AVG(CASE
         WHEN Marks.mark > 2 THEN Marks.mark
         ELSE NULL
       END) AS average_mark
FROM
   Disciplines
   JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
   JOIN Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
   JOIN Student ON Marks.student_id = Student.id
GROUP BY
   Disciplines.name;

-- Задание 5.6
SELECT TOP 1
   Groups.group_name,
   AVG(Marks.mark) AS average_mark
FROM
   Groups
   JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
   JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.direction_id = Directions_of_study.id
   JOIN Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
GROUP BY
   Groups.group_name
ORDER BY
   AVG(Marks.mark) DESC;

-- Задание 5.7
SELECT
   Student.full_name,
   AVG (Marks.mark)
FROM
   Student
   JOIN Marks ON Marks.student_id = Student.id
GROUP BY
   Student.full_name
HAVING
   AVG (Marks.mark) = 5;

-- Задание 5.8
SELECT
   Student.full_name
FROM
   Student
   JOIN Marks ON Marks.student_id = Student.id
WHERE
   Marks.mark = 2
GROUP BY
   Student.full_name
HAVING
   COUNT (*) > 1

-- Задание 7.1
SELECT
   COUNT (Attendance.id) AS num_presense
FROM
   Disciplines
   JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
   JOIN Lessons_shedule ON Lessons_shedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
   JOIN Attendance ON Attendance.schedule_id = Lessons_shedule.id
WHERE
   Disciplines.name = 'General psychology'
   AND Attendance.presense = 1
GROUP BY
   Attendance.presense;

-- Задание 7.2
SELECT
   COUNT (Attendance.id) AS num_presense
FROM
   Disciplines
   JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
   JOIN Lessons_shedule ON Lessons_shedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
   JOIN Attendance ON Attendance.schedule_id = Lessons_shedule.id
WHERE
   Disciplines.name = 'General psychology'
   AND Attendance.presense = 0
GROUP BY
   Attendance.presense;

-- Задание 7.3
SELECT
   COUNT (Attendance.id) AS num_presense,
   DirectionDisciplineTeacher.id
FROM
   Teachers
   JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.teacher_id = Teachers.id
   JOIN Lessons_shedule ON Lessons_shedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
   JOIN Attendance ON Attendance.schedule_id = Lessons_shedule.id
WHERE
   Teachers.name = 'Sergeev Sergey Sergeevich'
   AND Attendance.presense = 1
GROUP BY
   DirectionDisciplineTeacher.id;

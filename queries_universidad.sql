-- 1. List with first last name, middle last name, and first name of all students, ordered alphabetically.
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;
-- 2. First and last names of students who have not registered their phone number.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;
-- 3. List of students who were born in 1999.
SELECT * FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;
-- 4. List of teachers without phone number and NIF ending in K.
SELECT * FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND NIF LIKE '%K';
-- 5. List of subjects taught in first semester, third year of degree with identifier 7.
SELECT nombre FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
-- 6. List of professors with department name, ordered by last names and first name.
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS nombre_departamento FROM persona p INNER JOIN profesor pr ON p.id = pr.id_profesor INNER JOIN departamento d ON pr.id_departamento = d.id ORDER BY p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;
-- 7. List with subject names, start and end year of school year for student with NIF 26902806M.
SELECT a.nombre AS nombre_asignatura, ce.anyo_inicio, ce.anyo_fin FROM persona per INNER JOIN alumno_se_matricula_asignatura ama ON per.id = ama.id_alumno INNER JOIN asignatura a ON ama.id_asignatura = a.id INNER JOIN curso_escolar ce ON ama.id_curso_escolar = ce.id WHERE per.NIF = '26902806M';
-- 8. List with names of departments that have professors teaching in Computer Engineering Degree (2015 Plan).
SELECT DISTINCT d.nombre AS nombre_departamento FROM departamento d INNER JOIN profesor pr ON d.id = pr.id_departamento INNER JOIN asignatura a ON pr.id_profesor = a.id_profesor INNER JOIN grado g ON a.id_grado = g.id WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
-- 9. List of all students enrolled in a subject during 2018/2019 school year.
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2 FROM persona p INNER JOIN alumno_se_matricula_asignatura ama ON p.id = ama.id_alumno INNER JOIN curso_escolar ce ON ama.id_curso_escolar = ce.id WHERE p.tipo = 'alumno' AND ce.anyo_inicio = 2018 AND ce.anyo_fin = 2019;
-- 10. List with names of all professors and their departments, including professors without departments.
SELECT d.nombre AS nombre_departamento, p.apellido1, p.apellido2, p.nombre FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN departamento d ON pr.id_departamento = d.id WHERE p.tipo = 'profesor' ORDER BY nombre_departamento ASC, p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;
-- 11. List of teachers who are not associated with a department.
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p INNER JOIN profesor pr ON p.id = pr.id_profesor WHERE pr.id_departamento IS NULL;
-- 12. List of departments that do not have associated professors.
SELECT d.nombre AS nombre_departamento FROM departamento d LEFT JOIN profesor pr ON d.id = pr.id_departamento WHERE pr.id_profesor IS NULL;
-- 13. List of teachers who do not teach any subjects.
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p INNER JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE p.tipo = 'profesor' AND a.id IS NULL;
-- 14. List of subjects that do not have a teacher assigned.
SELECT a.nombre AS nombre_asignatura FROM asignatura a WHERE a.id_profesor IS NULL;
-- 15. List of all departments that have not taught subjects in any academic year.
SELECT d.nombre AS nombre_departamento FROM departamento d WHERE d.id NOT IN (SELECT DISTINCT pr.id_departamento FROM profesor pr INNER JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE a.id IS NOT NULL);
-- 16. Total number of existing students.
SELECT COUNT(*) AS total_alumnos FROM persona WHERE tipo = 'alumno';
-- 17. Number of students born in 1999.
SELECT COUNT(*) AS total_alumnos FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;
-- 18. Number of professors in each department (only departments with professors).
SELECT d.nombre AS departamento, COUNT(pr.id_profesor) AS numero_profesores FROM departamento d INNER JOIN profesor pr ON d.id = pr.id_departamento GROUP BY d.nombre ORDER BY numero_profesores DESC;
-- 19. List of all departments and number of professors in each (including departments without professors).
SELECT d.nombre AS nombre_departamento, COUNT(pr.id_profesor) AS numero_profesores FROM departamento d LEFT JOIN profesor pr ON d.id = pr.id_departamento GROUP BY d.nombre ORDER BY numero_profesores DESC;
-- 20. List with names of all degrees and number of subjects each offers.
SELECT g.nombre AS nombre_grado, COUNT(a.id) AS numero_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre ORDER BY numero_asignaturas DESC;
-- 21. List with names of degrees and number of subjects for degrees with more than 40 subjects.
SELECT g.nombre AS nombre_grado, COUNT(a.id) AS numero_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre HAVING numero_asignaturas > 40 ORDER BY numero_asignaturas DESC;
-- 22. List showing degree names and sum of credits for each type of subject.
SELECT g.nombre AS nombre_grado, a.tipo AS tipo_asignatura, SUM(a.creditos) AS total_creditos FROM grado g INNER JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre, a.tipo ORDER BY g.nombre, a.tipo;
-- 23. List showing how many students enrolled in a subject in each academic year.
SELECT ce.anyo_inicio, COUNT(DISTINCT ama.id_alumno) AS numero_alumnos_matriculados FROM curso_escolar ce INNER JOIN alumno_se_matricula_asignatura ama ON ce.id = ama.id_curso_escolar GROUP BY ce.anyo_inicio ORDER BY ce.anyo_inicio;
-- 24. List with number of subjects taught by each teacher (including teachers with no subjects).
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS numero_asignaturas FROM persona p INNER JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE p.tipo = 'profesor' GROUP BY p.id, p.nombre, p.apellido1, p.apellido2 ORDER BY numero_asignaturas DESC;
-- 25. All data for the youngest student.
SELECT * FROM persona WHERE tipo = 'alumno' ORDER BY fecha_nacimiento DESC LIMIT 1;
-- 26. List of professors with associated department who do not teach any subjects.
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p INNER JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE p.tipo = 'profesor' AND pr.id_departamento IS NOT NULL AND a.id IS NULL;
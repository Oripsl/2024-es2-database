-- NOME REPOSITORY: 2024-es2-database
-- Esercizi solo con SELECT
-- 1. Seleziona tutti i professori dal dipartimento di Informatica.
-- res:
select * from professor p
where p.department like 'Informatica';


-- 2. Elenca tutti gli studenti iscritti nell'anno 2021.
-- res:
select * from student s
where s.subscription_year = 2021;



-- 3. Visualizza tutti i corsi offerti dal dipartimento di Fisica.
-- res:
select * from course c
where c.department = 'Fisica';


-- 4. Mostra i nomi dei corsi insieme ai relativi dipartimenti.
-- res:
select c.name, c.department from course c;


-- 5. Conta il numero totale di studenti iscritti all'università.
-- res:
select count(*) from student s;


-- Esercizi con GROUP BY e HAVING
-- 6. Conta quanti corsi sono offerti in ogni dipartimento.
-- res:
select count(*) as conta, c.department  from course c
group by c.department;


-- 7. Trova i dipartimenti che hanno più di 3 corsi.
-- res:
select c.department from course c
group by c.department
having count(*) >= 1


-- 8. Elenca il numero di studenti iscritti per ogni anno di iscrizione.
-- res:
select count(*) as conta, s.subscription_year  from student s
group by subscription_year
order by subscription_year desc ;


-- 9. Mostra il numero medio di studenti per corso in ogni dipartimento.
-- res:
select
    c.department,
    AVG(sum.student_count) as average
from
    course c
join (
    select
        c.id AS course_id,
        COUNT(s.id) as student_count
    from
        course c
    join
        course_subscription cs on cs.course_id = c.id
    join
        student s on s.id = cs.student_id
    group by
        c.id
) sum on sum.course_id = c.id
group by
    c.department;


-- 10. Trova i professori che insegnano più di un corso.
-- res:
select p.*, count(c.id) as count from professor p
join course c on c.professor_id  = p.id
group by p.id
having count >= 1 ;

-- Esercizi con JOIN
-- res:



-- 11. Mostra il nome di ogni studente insieme al nome del corso a cui sono iscritti.
-- res:
select s.name as student_name, c.name as courseName from student s
join course_subscription cs on cs.student_id = s.id
join course c on cs.course_id = c.id



-- 12. Elenca tutti i corsi insieme ai nomi dei professori che li insegnano.
-- res:
select c.*, p.name as professorName  from course c
join professor p ON p.id = c.id


-- 13. Trova gli studenti e i corsi relativi al dipartimento di Chimica.
-- res:
select c.name , s.name from course c
join course_subscription cs on cs.course_id = c.id
join student s on s.id = cs.student_id
where c.department like 'Chimica';


-- 14. Visualizza i nomi degli studenti e i corsi che hanno frequentato nel 2022.
-- res:
select c.name as courseName , s.name as studentName, s.subscription_year  from course c
join course_subscription cs on cs.course_id = c.id
join student s on s.id = cs.student_id
where s.subscription_year  = 2022
order by studentName;


-- 15. Elencare i professori con i loro corsi e i relativi dipartimenti.
-- res:
select p.name as professor, c.name as corso, c.department as dipartimento from professor p
join course c ON c.professor_id = p.id
order by professor



-- 16. Trova i corsi senza studenti iscritti.
-- res:
select c.* from course c
join course_subscription cs on cs.course_id = c.id
where cs.student_id is null;



-- 17. Mostra i corsi con più di 5 iscritti.
-- res:
select c.*, count(cs.student_id) as students from course c
join course_subscription cs on cs.course_id = c.id
group by c.department, c.id, c.name
having students > 5
order by c.department;



-- 18. Elenca tutti i professori che non hanno corsi assegnati.
-- res:
select p.* from professor p
join course c on c.professor_id = p.id
where c.id is null;


-- 19. Visualizza i corsi con il maggior numero di studenti.
-- res:
select c.name, c.department , count(cs.student_id) as numStudenti from course c
join course_subscription cs on cs.course_id = c.id
group by c.department, c.name
order by numStudenti desc
limit 1;


-- 20. Trova gli studenti che sono iscritti a più di 3 corsi.
-- res:
select s.name, s.id, count(cs.course_id) as numCorsi from student s
join course_subscription cs on cs.student_id = s.id
group by s.name , s.id
having numCorsi > 3
order by s.name asc

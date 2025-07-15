use lab5;
CREATE TABLE COURSE(
    CourseID integer primary key,
    CourseName varchar(50),
    CourseFee integer,
    Instructor varchar(50)
);

INSERT INTO COURSE(CourseID,CourseName,CourseFee,Instructor)
VALUES
(11,'Programming',10000,'Ravi'),
(12,'C#',15000,'Jiban'),
(13,'Java',18000,'Janak'),
(14,'XML',5000,'Ravi'),
(15,'Database',12500,'Han'),
(16,'ASP.net',10000,'Shyam');


UPDATE COURSE
set Instructor='Ramesh'
WHERE CourseID=12;

SELECT count(Instructor), Instructor from COURSE
GROUP BY Instructor
HAVING COUNT(Instructor)>1; 


/* nesting the select avg(CouseFee) from COURSE)*/
SELECT CourseName from COURSE
WHERE CourseFee<(SELECT avg(CourseFee) from COURSE);


SELECT COUNT(distinct Instructor) from COURSE;



create table r(
a varchar(4),
b varchar(4)
);

create table s(
b varchar(4),
c varchar(4)
);

insert into r values('a1','b1');
insert into r values('a2','b2');
insert into r values('a3','b3');
insert into s values('b1','c1');
insert into s values('b2','c2');
insert into s values('b4','c4');


select * FROM r natural join s;

select a,r.b,s.c from r left join s on r.b=s.b;

select a,s.b,c from r right join s on r.b = s.b;


-- create view 
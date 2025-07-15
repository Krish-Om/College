CREATE TABLE course(
    cid VARCHAR(10),
    Cname VARCHAR(50),
    primary key(cid)
);

CREATE TABLE student(
    name VARCHAR(50),
    roll int primary key,
    cid VARCHAR(10),
    foreign key(cid) references course(cid)
);


INSERT INTO course(cid,Cname)
VALUES("S001","DBMS"),
        ("S002","TOC"),
        ("S003","CN"),
        ("S004","AI"),
        ("S005","OS");


INSERT INTO student(name,roll,cid) 
("Ram",1,"S001"),
("Shyam",2,"S002"),
("Hari",3,"S003"),
("Rita",4,"S001"),
("Sita",5,"S002"),
("Gita",6,"S003");

select * from student natural join course;

select * from student natural join course where cname='DBMS';

drop TABLE course;

INSERT INTO student VALUES('Kartik',7,'S007');
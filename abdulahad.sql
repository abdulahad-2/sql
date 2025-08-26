-- create department table
create table department(
 deptno int primary key,
 deptname varchar(255),
 location varchar(255)
);

-- create teacher table 
create table teacher(
 teacherid int primary key,
 teachername varchar(255),
 deptno int,
 foreign key (deptno) references department(deptno)
);

-- insert departments
insert into department values
(1,'Computer Science','Building A'),
(2,'Mathematics','Building B'),
(3,'Physics','Building C'),
(4,'History','Building D');

-- insert teachers
insert into teacher values
(101,'Dr. Alan Turing',1),
(102,'Dr. Isaac Newton',3),
(103,'Dr. Marie Curie',3),
(104,'Dr. Herodotus',4),
(105,'Dr. Ada Lovelace',1);

-- q1: show teachername and deptname in JSON
select t.teachername, d.deptname
from teacher t
join department d on t.deptno = d.deptno
for json path;

-- q2: insert new teacher
insert into teacher values(106,'Dr. Euclid',2);

-- q3: update deptno of teacherid=101 to 5
insert into department values(5,'Chemistry','Building E');
update teacher set deptno=5 where teacherid=101;

-- q4: create view for computer science teachers
create view ComputerScienceTeachers as
select t.teacherid, t.teachername, d.deptname, d.location
from teacher t
join department d on t.deptno = d.deptno
where d.deptname = 'Computer Science';

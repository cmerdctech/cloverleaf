
SELECT distinct role FROM Enrollments;
SELECT distinct categoryPath as schoolCode FROM NewCourses;
select count(*) from Users as p where p.department='STUDENT';
select count(*) from Users as p where p.department='PARENT';
select count(*) from Users as p where p.department='STAFF';

#look for duplicate users
select * from Users as u1
where (select count(*) from Users as u2 where u1.userName=u2.userName or u1.personId=u2.personId)>1
order by lastName, firstName;

#look for duplicate users with students
select u1.personId, u1.lastName, u1.firstName, u1.schoolCode,
student.lastName, student.firstName
from Users as u1
left join Parents as p on p.personId=u1.personId
left join Users as student on student.personId=p.studentUniqueIdentifier
where (select count(*) from Users as u2 where u1.userName=u2.userName or u1.personId=u2.personId)>1
order by lastName, firstName;

select distinct userName, personId from Users;
select userName, personId from Users;


select u.userName, u.personId, u.lastName, s.firstName, s.lastName, u.firstName from Users as u1
left join Parents as p on p.personId=p.personId
left join Users as s on s.personId=p.studentUniqueIdentifier
where (select count(*) from Users as u2 where u1.firstName=u2.firstName and u1.lastName=u2.lastName)>1
order by lastName, firstName;

select * from Users as p where p.department='PARENT';

#people with a student
create index tmp on Parents (studentUniqueIdentifier);
select distinct
parent.firstName as 'parent.firstName', 
parent.lastName as 'parent.lastName', 
student.firstName as 'student.firstName', 
student.lastName as 'student.lastName', 
parent.schoolCode as 'parent.schoolCode', 
student.schoolCode as 'student.schoolCode '
from Parents as p
left join Users as parent on parent.personId=p.personId
left join Users as student on student.personId=p.studentUniqueIdentifier
where (select count(*) from Parents as s2 where s2.studentUniqueIdentifier=p.studentUniqueIdentifier)>0
order by parent.lastName, parent.firstName;

select count(*) from Parents as p
left join Users as student on student.personId=p.studentUniqueIdentifier
where p.studentUniqueIdentifier = "";

select (select count(*) from Users as s2 where s2.personId=p.studentUniqueIdentifier) from Parents as p
where (select count(*) from Users as s2 where s2.personId=p.studentUniqueIdentifier)>1;

select u.* from Parents as p
left join Users as u on u.personId=p.personId
where p.studentUniqueIdentifier='418109060';


select count(*) from Parents as p;

select * from Users as p
where p.department='PARENT';

select * from Users as p
where p.department='STUDENT';

select distinct personId from Parents;

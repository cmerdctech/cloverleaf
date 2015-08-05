create table tmpDistinct
select distinct u1.personId, u1.lastName, u1.firstName, u1.schoolCode,
student.lastName as 'studentLast', student.firstName as 'studentFirst', student.schoolCode as 'studentSchool',
'12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890' as bigHash
from Users as u1
left join Parents as p on p.personId=u1.personId
left join Users as student on student.personId=p.studentUniqueIdentifier;


create table tmpAll
select u1.personId, u1.lastName, u1.firstName, u1.schoolCode,
student.lastName as 'studentLast', student.firstName as 'studentFirst', student.schoolCode as 'studentSchool',
'12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890' as bigHash
from Users as u1
left join Parents as p on p.personId=u1.personId
left join Users as student on student.personId=p.studentUniqueIdentifier;
 

update tmpAll set bigHash= CONCAT(COALESCE(`personId`,''), COALESCE(`lastName`,''), COALESCE(`firstName`,''), COALESCE(`schoolCode`,''), COALESCE(`studentLast`,''), COALESCE(`studentFirst`,''), COALESCE(`studentSchool`,''));
update tmpDistinct set bigHash= CONCAT(COALESCE(`personId`,''), COALESCE(`lastName`,''), COALESCE(`firstName`,''), COALESCE(`schoolCode`,''), COALESCE(`studentLast`,''), COALESCE(`studentFirst`,''), COALESCE(`studentSchool`,''));

select CONCAT(COALESCE(`personId`,''), COALESCE(`lastName`,''), COALESCE(`firstName`,''), COALESCE(`schoolCode`,''), COALESCE(`studentLast`,''), COALESCE(`studentFirst`,''), COALESCE(`studentSchool`,'')) 
from tmpDistinct where isnull(bigHash);

select  * from tmpAll where studentLast = '';

select *, (select count(*) from tmpAll as td2 where td2.bigHash=ta.bigHash)
from tmpDistinct as ta
where (select count(*) from tmpAll as td where td.bigHash=ta.bigHash)>1;
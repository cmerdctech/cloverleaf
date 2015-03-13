update Enrollments as e 
set classGroup=(select classGroup from classGroupNames as cgn where e.courseId=cgn.courseId)
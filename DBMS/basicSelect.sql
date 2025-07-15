SELECT DISTINCT sID,sName,GPA,sizeHS, GPA*(sizeHS/1000.0) AS scaledGPA
from Student;



-- SELECT * from Student,College;

-- SELECT DISTINCT *
-- from Apply
-- WHERE major like '%m%'; 


--  select distinct sname,GPA,decision
--  from Student,Apply
--  where Student.sID = Apply.sID
--  and sizeHS <1000 and major = 'CS' and cname ='MIT' or cname='Stanford';

--  select distinct College.cName
--  from College,Apply
--  where College.cName = Apply.cName
--  and enrollment > 2000 and major = 'CS';

--  select Student.sID,sName,GPA,Apply.cName,enrollment
--  from Student,College,Apply
--  where Apply.sID=Student.sID and Apply.cName = College.cName;

--  select distinct Student.sID,sName,GPA,Apply.cName,enrollment
--  from Student,College,Apply
--  where Apply.sID=Student.sID and Apply.cName = College.cName
--  order by GPA desc,enrollment;



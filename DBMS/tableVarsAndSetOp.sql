-- Equivalent to except operator
SELECT DISTINCT A1.sID
FROM Apply A1,Apply A2
WHERE A1.sID = A2.sID and A1.major = 'CS' and A2.major <> 'EE';

-- Except set operation
SELECT sId from Apply WHERE major = 'CS'
except
SELECT sID from Apply where major = 'EE';



-- Equivalent to intersect
SELECT  DISTINCT A1.sID
FROM Apply A1, Apply A2 
WHERE A1.sID = A2.sID and A1.major = 'CS' and A2.major='EE';

SELECT sId from Apply WHERE major = 'CS'
intersect 
SELECT sID from Apply where major = "EE";
-- SELECT sName FROM Student;
SELECT cName as name FROM College
UNION ALL
SELECT sName as name from Student
ORDER BY name;

-- SELECT S1.sID, S1.sName,S1.GPA,S2.sID,S2.sName
-- FROM Student S1, Student S2 -- S1xS2
-- WHERE S1.GPA = S2.GPA AND S1.sID > S2.sID
-- ;
-- SELECT S.sID,sName,GPA,A.cName,enrollment
-- FROM Student S,College C,Apply A  -- Here is the use of table variables
-- WHERE A.sID = S.sID and A.cName = C.cName;



-- SELECT A1,A2,...An
-- From R1,R2...Rn  <==Table Variables
--                     Set Operators:
--                     Union,Intersect,Except
-- where condition




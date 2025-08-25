-- 5. Assume a database about Company,
-- Employee(ss#, name)
-- Company(cname, address)
-- Works(ss#, cname)
-- Supervises(supervisor_ss#, employee_ss#)
[Previous code remains the same until the Relational Algebra section]

-- Relational Algebra for Query (a):
-- π_name (σ_address='Kathmandu' (Employee ⨝ Supervises ⨝ Works ⨝ Company))

-- Relational Algebra for Query (b):
-- γ_cname, COUNT(DISTINCT supervisor_ss_num)>4 (Company ⨝ Works ⨝ Supervises)

-- Relational Algebra for Query (c):
-- π_name (γ_supervisor_ss_num, COUNT(*) AS emp_count (Supervises) ⨝ Employee) 
-- WHERE emp_count = MAX(emp_count)


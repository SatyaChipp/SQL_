"""
Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a 
parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the 
following format:

There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase 
occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.
"""

select name + "(" + substring(occupation, 1, 1) + ")"
from occupations
order by name;
select "There are a total of " + str(count(occupation)) + " " + lower(occupation) + "s."
from occupations
group by occupation
order by count(occupation) asc, occupation asc;
                                           
----------------------------------------------------------
""" 
Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.                                           
"""
select n, 
    case when p is null then 'Root'
        when (select count(*) from bst where p=b.n)>0 then 'Inner'
        else 'Leaf'
    end 
from bst as b
order by n;
---------------------------------------------------------
"""
Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of 
senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.
The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. For example, if the company_codes are C_1, C_2, and C_10, then the 
ascending company_codes will be C_1, C_10, and C_2.
"""

select c.company_code, c.founder, count(distinct e.lead_manager_code), count(distinct e.senior_manager_code), 
count(distinct e.manager_code), count(distinct e.employee_code)
from company c
    inner join employee e
    on c.company_code = e.company_code
group by c.company_code, c.founder
order by c.company_code;
--------------------
select c.company_code, c.founder, 
    count(distinct l.lead_manager_code), count(distinct s.senior_manager_code), 
    count(distinct m.manager_code),count(distinct e.employee_code) 
from Company c, Lead_Manager l, Senior_Manager s, Manager m, Employee e 
where c.company_code = l.company_code 
    and l.lead_manager_code=s.lead_manager_code 
    and s.senior_manager_code=m.senior_manager_code 
    and m.manager_code=e.manager_code 
group by c.company_code, c.founder
order by c.company_code;

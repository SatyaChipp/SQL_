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
                                           
                                           /*
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

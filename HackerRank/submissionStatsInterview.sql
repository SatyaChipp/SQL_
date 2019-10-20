"""
Samantha interviews many candidates from different colleges using coding challenges and contests. Write a query to print the 
contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views 
for each contest sorted by contest_id.
Exclude the contest from the result if all four sums are .
Note: A specific contest can be used to screen candidates at more than one college, but each college only holds  screening contest.
"""

with sumViewStats as (
    select challenge_id, sum(total_views) as total_views, sum(total_unique_views) as total_unique_views 
    from view_stats
    group by challenge_id
),
sumSubmissionStats as (
    select challenge_id, sum(total_accepted_submissions) as total_accepted_submissions, sum(total_submissions) as total_submissions
    from submission_stats
    group by challenge_id
)


select c.contest_id, c.hacker_id, c.name, sum(total_submissions), sum(total_accepted_submissions), sum(total_views), sum(total_unique_views)
from contests c
    inner join colleges co
    on co.contest_id = c.contest_id
    
    inner join challenges cl
    on cl.college_id = co.college_id
    
    left join sumViewStats v
    on v.challenge_id = cl.challenge_id
    
    left join sumSubmissionStats s 
    on cl.challenge_id = s.challenge_id
group by c.contest_id, c.hacker_id, c.name
having (sum(total_submissions) + sum(total_accepted_submissions) + sum(total_views) + sum(total_unique_views))<>0
order by c.contest_id;

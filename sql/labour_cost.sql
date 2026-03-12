SELECT 
p.project_id,
p.client_name,
SUM(l.daily_wage)
FROM dbo.projects as p
LEFT JOIN dbo.daily_labour as l
on p.project_id=l.project_id
GROUP BY p.project_id,p.client_name

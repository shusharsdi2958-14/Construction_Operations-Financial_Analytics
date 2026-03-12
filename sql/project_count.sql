SELECT 
p.project_status,
COUNT(*) as project_count
FROM dbo.projects p
group by p.project_status
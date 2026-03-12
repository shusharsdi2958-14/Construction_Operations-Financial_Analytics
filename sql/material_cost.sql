SELECT 
p.project_id,
p.client_name,
SUM(m.total_cost) as total_material_cost
FROM dbo.projects p
LEFT JOIN dbo.material_purchase m
ON p.project_id=m.project_id
GROUP BY p.project_id,p.client_name
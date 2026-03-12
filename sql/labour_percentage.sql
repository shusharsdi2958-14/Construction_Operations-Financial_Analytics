SELECT
p.project_id,
p.client_name,
(ISNULL(SUM(l.daily_wage),0)*100)/NULLIF(p.total_contract_amount,0) as labour_percent
FROM
dbo.projects p
LEFT JOIN dbo.daily_labour l 
ON p.project_id=l.project_id
GROUP BY p.project_id,p.client_name,p.total_contract_amount
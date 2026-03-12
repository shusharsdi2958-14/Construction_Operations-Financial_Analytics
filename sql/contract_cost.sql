SELECT 
p.project_id,
p.client_name,
p.total_contract_amount as total_budjet,
ISNULL(SUM(c.contract_amount),0) as contract_amount,
(ISNULL(SUM(c.contract_amount),0)*100)/p.total_contract_amount as contract_percentage
FROM dbo.projects as p
LEFT JOIN dbo.contract_work as c
on p.project_id=c.project_id
GROUP BY p.project_id,p.client_name,p.total_contract_amount 
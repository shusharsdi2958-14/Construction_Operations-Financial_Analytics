WITH material_cost as(
	SELECT 
		project_id,
		SUM(total_cost) as total_material
	FROM dbo.material_purchase
	GROUP BY project_id
	),
labour_cost as(
	SELECT 
		project_id,
		SUM(daily_wage) as total_labour
	FROM dbo.daily_labour
	GROUP BY project_id
	),
contract_cost as(
	SELECT 
		project_id,
		SUM(contract_amount) as total_contract
	FROM dbo.contract_work
	GROUP BY project_id
	),
Project_total as(
	SELECT 
	p.project_id,
	p.client_name,
	p.total_contract_amount,
	(ISNULL(m.total_material,0)+
	ISNULL(l.total_labour,0)+
	ISNULL(c.total_contract,0)) as total_cost
	FROM dbo.projects p
	LEFT JOIN material_cost m ON p.project_id=m.project_id
	LEFT JOIN labour_cost l ON p.project_id=l.project_id
	LEFT JOIN contract_cost c ON p.project_id=c.project_id
	)
SELECT 
project_id,
client_name,
total_contract_amount,
total_cost,
(total_cost-total_contract_amount) as over_budjet_amount
FROM 
Project_total
WHERE total_cost>total_contract_amount
ORDER  BY over_budjet_amount

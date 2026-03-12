WITH material_cost as(
SELECT
	m.project_id,
	ISNULL(SUM(m.total_cost),0) as material_cost
	FROM 
	dbo.material_purchase m
    GROUP BY m.project_id
	),
labour_cost as(
	SELECT
	l.project_id,
	ISNULL(SUM(l.daily_wage),0) as labour_cost
	FROM
	dbo.daily_labour l
	GROUP BY l.project_id
	--order by l.project_id
	),
contract_cost as(
	SELECT
	c.project_id,
	ISNULL(SUM(c.contract_amount),0) as contract_cost
	FROM
	dbo.contract_work c
	GROUP BY c.project_id
	),
revenue as(
	SELECT
	r.project_id,
	ISNULL(SUM(r.payment_amount),0) as total_revenue
	FROM 
	dbo.customer_payment r
	GROUP BY r.project_id
	)
SELECT
	p.project_id,
	p.client_name,
	p.total_contract_amount,
	ISNULL(SUM(r.total_revenue),0) as total_reveue,

	ISNULL(SUM(m.material_cost),0)+
	ISNULL(SUM(l.labour_cost),0)+
	ISNULL(SUM(c.contract_cost),0) as total_cost,
	
	ISNULL(SUM(r.total_revenue),0)-
	(ISNULL(SUM(m.material_cost),0)+
	ISNULL(SUM(l.labour_cost),0)+
	ISNULL(SUM(c.contract_cost),0)) as profit_loss
FROM
	dbo.projects p
	LEFT JOIN material_cost m ON p.project_id=m.project_id
	LEFT JOIN labour_cost l ON p.project_id=l.project_id
	LEFT JOIN contract_cost c ON p.project_id=c.project_id
	LEFT JOIN revenue r ON p.project_id=r.project_id
	GROUP BY p.project_id,p.client_name,p.total_contract_amount

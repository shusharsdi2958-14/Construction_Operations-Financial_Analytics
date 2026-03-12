SELECT 
p.project_id,
p.client_name,
p.total_contract_amount,
SUM(c.payment_amount) as total_amount_paid,
p.total_contract_amount-SUM(c.payment_amount) as pending_amount
FROM dbo.projects as p
LEFT JOIN dbo.customer_payment as c
on p.project_id=c.project_id 
GROUP BY p.project_id,p.client_name,p.total_contract_amount
SELECT 
p.project_id,
p.client_name,
SUM(c.payment_amount) as total_amount_paid
FROM dbo.projects as p
LEFT JOIN dbo.customer_payment as c
on p.project_id=c.project_id
GROUP BY p.project_id,p.client_name
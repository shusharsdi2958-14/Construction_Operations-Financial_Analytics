SELECT TOP 5
dealer_name,
ISNULL(SUM(total_cost),0) as total_cost
FROM
dbo.material_purchase
GROUP BY dealer_name
ORDER BY ISNULL(SUM(total_cost),0) DESC
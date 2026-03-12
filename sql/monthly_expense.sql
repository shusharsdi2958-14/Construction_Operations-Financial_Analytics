WITH all_expenses as(
	SELECT
		work_date as expense_date,
		daily_wage as amount,
		'Labour' as expense_type
	FROM dbo.daily_labour
UNION ALL
	SELECT
		purchase_date as expense_date,
		total_cost as amount,
		'Material' as expense_type
	FROM dbo.material_purchase
UNION ALL
	SELECT
		payment_date as expense_date,
		payment_amount as amount,
		'Contractor_Payment' as expense_type
	FROM dbo.contractor_payment
	where payment_status='Paid'
)
SELECT FORMAT(expense_date,'yyyy-MMM') as expense_month,
	ISNULL(SUM(CASE WHEN expense_type='Labour' THEN amount else 0 END),0) as total_labour_cost,
	ISNULL(SUM(CASE WHEN expense_type='Material' THEN amount else 0 END),0) as total_material_cost,
	ISNULL(SUM(CASE WHEN expense_type='Contractor_Payment' THEN amount else 0 END),0) as total_contract_cost,

	ISNULL(SUM(amount),0) as total_monthly_expenses
	FROM all_expenses
	WHERE expense_date IS NOT NULL
	GROUP BY FORMAT(expense_date,'yyyy-MMM'),
			YEAR(expense_date),
			MONTH(expense_date)
	ORDER BY YEAR(expense_date),
			MONTH(expense_date)
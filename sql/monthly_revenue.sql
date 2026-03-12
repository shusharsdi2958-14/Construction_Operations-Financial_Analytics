SELECT 
	FORMAT(payment_date,'yyyy-MMM') as payment_month,
	ISNULL(SUM(payment_amount),0) as monthly_revenue
	FROM dbo.customer_payment
	group by FORMAT(payment_date,'yyyy-MMM'),
			 YEAR(payment_date),
			 MONTH(payment_date)
	ORDER BY YEAR(payment_date),
			MONTH(payment_date)
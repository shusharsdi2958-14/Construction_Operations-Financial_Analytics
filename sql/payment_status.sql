SELECT
payment_status,
sum(payment_amount)as payment_amount
from dbo.contractor_payment
group by payment_status
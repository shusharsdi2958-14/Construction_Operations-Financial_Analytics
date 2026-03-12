SELECT
project_id,
ROUND(AVG(daily_wage),2)as avg_labour_cost
from
dbo.daily_labour
GROUP BY project_id
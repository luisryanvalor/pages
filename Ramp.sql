/* Using this dataset, show the SQL query to find the rolling 3 day average transaction amount for each day in January 2021. */

-- calculate total transaction amount per day
with daily_amount as (
	select 
		transaction_time::date as date,
		sum(transaction_amount) as total_daily_amount
	from transactions
	group by date
),
-- calculate the daily rolling 3 day average
rolling_avg as (
	select
		date,
  		total_daily_amount,
        -- returns average amount of the previous three days
  		avg(total_daily_amount) over (order by date rows between 3 preceding and 1 preceding) as rolling_three_day_average
	from daily_amount
)
select 
 	date,
    rolling_three_day_average
from rolling_avg
where date = '2021-01-31';
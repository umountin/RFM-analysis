INSERT INTO analysis.tmp_rfm_monetary_value (user_id, monetary_value)
WITH u AS (
	SELECT 
		DISTINCT id AS user_id
	FROM analysis.users
),
q AS (
	SELECT 
		o.user_id,
		SUM(o.cost) AS ld
	FROM analysis.orders o
	WHERE o.status = 4
	AND CAST(DATE_TRUNC('year', o.order_ts) AS date) > '2021-01-01'
	GROUP BY o.user_id
)
SELECT
	u.user_id,
	ntile(5) OVER (ORDER BY COALESCE(q.ld,0)) AS monetary_value
FROM u
LEFT JOIN q ON u.user_id = q.user_id;

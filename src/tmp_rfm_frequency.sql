INSERT INTO analysis.tmp_rfm_frequency (user_id, frequency)
WITH u AS (
	SELECT 
		DISTINCT id AS user_id
	FROM analysis.users
),
q AS (
	SELECT 
		o.user_id,
		COUNT(o.order_id) AS ld
	FROM analysis.orders o
	WHERE o.status = 4
	AND CAST(DATE_TRUNC('year', o.order_ts) AS date) > '2021-01-01'
	GROUP BY o.user_id
)
SELECT
	u.user_id,
	ntile(5) OVER (ORDER BY COALESCE(q.ld,0)) AS frequency
FROM u
LEFT JOIN q ON u.user_id = q.user_id;

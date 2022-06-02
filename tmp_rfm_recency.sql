INSERT INTO analysis.tmp_rfm_recency (user_id, recency)
WITH u AS (
	SELECT 
		DISTINCT id AS user_id
	FROM analysis.users
),
q AS (
	SELECT 
		o.user_id,
		MAX(o.order_ts) AS ld
	FROM analysis.orders o
	WHERE o.status = 4
	AND CAST(DATE_TRUNC('year', o.order_ts) AS date) > '2021-01-01'
	GROUP BY o.user_id
)
SELECT
	u.user_id,
	ntile(5) OVER (ORDER BY COALESCE(q.ld,'1900-01-01')) AS recency
FROM u
LEFT JOIN q ON u.user_id = q.user_id;

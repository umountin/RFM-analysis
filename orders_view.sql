CREATE OR REPLACE VIEW analysis.orders AS
WITH q AS (
	SELECT * FROM production.orders
),
ld AS (
	SELECT
		l.order_id,
		MAX(l.dttm) AS last_date
	FROM production.OrderStatusLog l	
	GROUP BY l.order_id 
	ORDER BY l.order_id 
),
s AS (
	SELECT
		l.order_id,
		l.status_id AS status,
		l.dttm
	FROM production.OrderStatusLog l
	ORDER BY l.order_id 
)
SELECT
	q.*,
	s.status
FROM ld
LEFT JOIN s ON s.order_id = ld.order_id AND s.dttm = ld.last_date
RIGHT JOIN q ON q.order_id = ld.order_id;

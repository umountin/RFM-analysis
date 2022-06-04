CREATE OR REPLACE VIEW analysis.orders AS
WITH q AS (
	SELECT * FROM production.orders
),
s AS (
	SELECT
		l.order_id,
		l.status_id,
		ROW_NUMBER() OVER (PARTITION BY l.order_id, l.status_id ORDER BY l.dttm DESC) last_row
	FROM production.OrderStatusLog l
)
SELECT
	q.*,
	s.status_id AS status
FROM q
LEFT JOIN s ON s.order_id = q.order_id
WHERE s.last_row = 1
ORDER BY q.order_id;

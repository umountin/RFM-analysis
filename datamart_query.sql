INSERT INTO analysis.dm_rfm_segments
SELECT 
	r.user_id,
	r.recency,
	f.frequency,
	m.monetary_value
FROM analysis.tmp_rfm_recency r
JOIN analysis.tmp_rfm_frequency f ON f.user_id = r.user_id
JOIN analysis.tmp_rfm_monetary_value m ON m.user_id = r.user_id
ORDER BY r.user_id;

#	user_id	recency	frequency	monetary_value
1	0	1	3	4
2	1	4	3	3
3	2	2	3	5
4	3	2	3	3
5	4	4	3	3
6	5	5	5	5
7	6	1	3	5
8	7	4	2	2
9	8	1	1	3
10	9	1	3	2

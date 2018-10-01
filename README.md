# Rails Interview

## 1. We have in our database the table `​payments​` that looks as described below. Please write a SQL query that ​returns the best performing **day** of 2016 in terms of total daily revenue.

```
DESCRIBE payments;
+------------+------------------+------+-----+---------+----------------+
| Field      | Type             | Null | Key | Default | Extra          |
+------------+------------------+------+-----+---------+----------------+
| id         | int(11) unsigned | NO   | PRI | NULL    | auto_increment |
| user_id    | int(11)          | YES  | MUL | NULL    |                |
| amount     | int(11)          | YES  |     | NULL    |                |
| issue_date | datetime         | YES  | MUL | NULL    |                |
+------------+------------------+------+-----+---------+----------------+
```

```sql
SELECT DATE(issue_date) AS day, SUM(amount) AS total_revenue
FROM payments
WHERE YEAR(issue_date) = 2016
GROUP BY day
ORDER BY total_revenue DESC
LIMIT 1
```

(see commit for all details)

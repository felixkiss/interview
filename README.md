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

## 2. We define a ​Blog​ RoR application in which users can write Posts and they can Comment on Posts.

### 2.1. How would you build the schema for the database tables that we need for the Blog application described above?

```
rails generate model User
rails generate model Post user:references:index content:text
rails generate model Comment user:references:index post:references:index content:text
rails db:migrate
```

### 2.2. How do you define the Rails models corresponding to the tables above? What associations are declared and how?

The belongs_to associations are already defined by the generators above. We need to manually specify the inverse of the belongs_to associations.

Full list of associations:
 - Post belongs_to :user
 - User has_many :posts (needs to added manually)
 - Comment belongs_to :post
 - Comment belongs_to :user
 - User has_many :comments (needs to added manually)
 - Post has_many :comments (needs to added manually)

See commit for all model classes.

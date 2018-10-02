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

### 2.3. How many queries are done to the DB for the following code?

The code below updates the username of all comments on all posts.

```ruby
class User < ActiveRecord::Base
  def close_account
    # some code that handles account closing

    # Mark the user’s posts as deleted
    # and all the comments on those posts

    all_posts = self.posts
    all_posts.each do |post|
      post.deleted = true
      post.save!
    end

    comments = all_posts.map(&:comments).flatten
    comments.each do |comment|
      comment.deleted = true
      comment.save!
    end
  end
end
```

The following queries are executed before optimization:
 - `self.posts` executes a single `SELECT` query to get all posts of the user
 - `post.save!` will execute one `UPDATE` query per post of the user
 - `all_posts.map(&:comments)` will execute one `SELECT` query per post of the user
 - `comment.save!` will execute one `UPDATE` query per comment on the user's posts

How would you optimise this code?

This is a classic example of the n+1 problem. The number of queries should not scale proportionally with the number of database entries. Since we only want to update a simple boolean flag, I would suggest the following:

```ruby
def close_account
  # some code that handles account closing

  # Mark the user's posts as deleted
  self.posts.update_all(deleted: true)

  # and all the comments on those posts
  Comment.where("post_id IN (SELECT id FROM posts WHERE user_id = ?)", self.id).update_all(deleted: true)
end
```

This will only execute two queries, regardless of the number of entries in the database:
 - `self.posts.update_all` will execute an `UPDATE` query for the `posts` table
 - `Comment.where(...).update_all` will execute an `UPDATE` query for the `comments` table

While being performant, this also has some drawbacks:
 - Strong coupling with the database. In case the table or involved columns are renamed this code has to be updated as well
 - [`update_all`](https://api.rubyonrails.org/classes/ActiveRecord/Relation.html#method-i-update_all) will not instantiate the involved AR models and thus will not trigger Active Record callbacks and validations. This can lead to weird bugs if a developer expects these to be run whenever a post/comment gets deleted

### 2.4. Format rendering

Given the blog application above how would you write the code for displaying a blog post (along with author, content, comments) for the following request formats: html, xml, json.

I've only implemented `posts#show`. See commit for details

### 2.5. Routing

Assuming that listing all posts will be handled by the ​www.myblog.com​ URL, individual posts will be at ​www.myblog.com/posts/123​, please define how the basic structure of the routes.rb file would look.

```ruby
Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, only: [:index, :show]
end
```

## 3. How would you define a Person model so that any Person can be assigned as the parent of another Person (as demonstrated in the Rails console below)?

```ruby
irb(main):001:0> john = Person.create(name: "John")
irb(main):002:0> jim = Person.create(name: "Jim", parent: john)
irb(main):003:0> bob = Person.create(name: "Bob", parent: john)
irb(main):004:0> john.children.map(&:name) => ["Jim", "Bob"]
```

What columns would you need to define in the migration creating the table for Person?

```ruby
create_table :people do |t|
  t.string :name
  t.references :parent, foreign_key: {to_table: :people}

  t.timestamps
end
```

And for a more advanced challenge:

Update the Person model so that you can also get a list of all of a person’s grandchildren, as illustrated below. Would you need to make any changes to the corresponding table in the database?

```ruby
irb(main):001:0> sally = Person.create(name: "Sally")
irb(main):002:0> sue = Person.create(name: "Sue", parent: sally)
irb(main):003:0> kate = Person.create(name: "Kate", parent: sally)
irb(main):004:0> lisa = Person.create(name: "Lisa", parent: sue)
irb(main):005:0> robin = Person.create(name: "Robin", parent: kate)
irb(main):006:0> donna = Person.create(name: "Donna", parent: kate)
irb(main):007:0> sally.grandchildren.map(&:name) => ["Lisa", "Robin", "Donna"]
```

No changes to the database structure are necessary. Method `grandchildren` could look like this:

```ruby
def grandchildren
  children.map(&:children).flatten
end
```

See commit for corresponding spec.

## 4. Create a route to be able to display pages with different information about different types of beer.

The route should recognize URL paths like `/beer/<beer_type>` and should use the same controller action for each type of beer with the actually beer type passed into the controller action as a parameter. The valid beer types are:

 - IPA
 - brown_ale
 - pilsner
 - lager
 - lambic
 - hefeweizen

Any other type of beer specified should generate a 404 status code.

See commit for my solution.

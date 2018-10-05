class User < ApplicationRecord
  has_many :comments
  has_many :posts

  def close_account
    # some code that handles account closing

    # Mark the user's posts as deleted
    self.posts.update_all(deleted: true)

    # and all the comments on those posts
    Comment.where("post_id IN (SELECT id FROM posts WHERE user_id = ?)", self.id).update_all(deleted: true)
  end
end

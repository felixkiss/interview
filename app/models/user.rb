class User < ApplicationRecord
  has_many :comments
  has_many :posts

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

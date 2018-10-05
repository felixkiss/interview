json.(comment, :content, :created_at)
json.author comment.user, partial: "users/user", as: :user

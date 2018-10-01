json.(post, :content, :created_at)

json.author post.user, partial: "users/user", as: :user
json.comments post.comments, partial: "comments/comment", as: :comment

json.url post_url(post, format: :json)

xml.post do
  xml.content post.content
  xml.created_at post.created_at

  xml << render(post.user)
  xml.comments do
    post.comments.each do |comment|
      xml << render(comment)
    end
  end

  xml.url post_url(post, format: :xml)
end

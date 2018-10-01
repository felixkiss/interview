xml.comment do
  xml.content comment.content
  xml.created_at comment.created_at

  xml << render(comment.user)
end

xml.instruct!
xml.posts do
  @posts.each do |post|
    xml << render(post)
  end
end

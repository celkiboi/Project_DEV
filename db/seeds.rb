5.times do |i|
  user = User.new(
    name: "User#{i + 1}",
    lastname: "LastName#{i + 1}",
    email: "user#{i + 1}@example.com",
    password: "password123",
    password_confirmation: "password123"
  )

  if user.save
    20.times do |j|
      post = user.posts.create(
        title: "Post Title #{j + 1} by User #{i + 1}",
        short_description: "Short description for post #{j + 1}.",
        content: "This is the content for post number #{j + 1}.",
        publish_date: Date.today - rand(1..30).days,
        published: true,
        public: true
      )

      puts post.errors.full_messages unless post.valid?
    end
  else
    puts user.errors.full_messages
  end
end

Admin.create!(
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  name: "Admin",
  lastname: "User"
)

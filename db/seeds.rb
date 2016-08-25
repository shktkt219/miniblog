#User
User.create!(name: "Example User",
             email: "example@rails.net",
             password: "fooooooo",
             password_confirmation: "fooooooo",
             admin: true)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@rails.net"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

#Post
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(content: content)}
end

#Relationship
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

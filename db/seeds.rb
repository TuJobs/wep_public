User.create! name:  "Nguyen Van Tu", email: "vantu1904@gmail.com",
  password: "19041996", password_confirmation: "19041996", is_admin: true

30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name, email: email, password: password,
    password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each {|user| user.posts.create!(content: content)}
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}

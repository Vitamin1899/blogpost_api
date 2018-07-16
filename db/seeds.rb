ips = []
50.times do
  ips << Faker::Internet.ip_v4_address
end
100.times do
  user = User.create(login: Faker::Internet.user_name)

  2000.times do
    post = user.posts.create(
      title: Faker::Lorem.word,
      content: Faker::Lorem.sentence,
      author_ip: ips.sample
    )
    next if [true, false].sample
    5.times do
      post.ratings.create(value: Faker::Number.between(1, 5))
    end
  end
end

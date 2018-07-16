FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.word }
    content { Faker::Lorem.sentence }
    author_ip { Faker::Internet.ip_v4_address }
  end
end

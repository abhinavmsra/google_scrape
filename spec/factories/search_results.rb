FactoryGirl.define do
  factory :search_result do |f|
    f.key_word { Faker::Lorem.word }
    f.links_count { Faker::Number.between(1, 10) }
    f.search_count { Faker::Number.between(1, 10) }
    f.html_code { Faker::Hipster.paragraph }
    f.worker_ip { Faker::Internet.ip_v4_address }
    user
  end
end

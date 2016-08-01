FactoryGirl.define do
  factory :link do |f|
    f.link_type { Faker::Number.between(0, 2) }
    f.url { Faker::Internet.url }
    search_result
  end
end

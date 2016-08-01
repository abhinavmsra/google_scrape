FactoryGirl.define do
  factory :user do |f|
    f.provider 'google'
    f.uid { Faker::Number.number(10) }
    f.name { Faker::Name.name  }
    f.url { Faker::Internet.url  }
  end
end

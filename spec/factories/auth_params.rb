FactoryGirl.define do
  factory :auth_param, class: Hash do
    provider 'google'
    uid { Faker::Number.number(10) }
    info {{
      'name' => "#{Faker::Name.name}",
      'urls' => {
        'Google' => "#{Faker::Internet.url}"
      }
    }}

    initialize_with { attributes }
  end

  factory :info, class: Hash do

  end
end

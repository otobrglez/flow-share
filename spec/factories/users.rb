FactoryGirl.define do
  sequence(:email) { |n| "test#{n}@example.com" }
  sequence(:username) { |n| "user#{n}" }

  factory :user, aliases: [:creator, :other_user] do
    email { generate(:email) }
    full_name { Faker::Name.name }
    username { generate(:username) }
    password 'testtest'
    password_confirmation { password }

    after(:create){ |user| user.confirm! }
  end
end

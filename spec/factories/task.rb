FactoryGirl.define do
  factory :task do
    title { Faker::Name.title }
  end
end

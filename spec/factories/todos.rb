FactoryBot.define do
  factory :todo do
    title { "Sample Todo" }
    description { "Sample Description" }
    completed { false }
    association :user
  end
end

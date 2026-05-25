FactoryBot.define do
  factory :task do
    association :project
    description { "A task description." }
    completed { false }
  end
end

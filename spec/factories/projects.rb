FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Project #{n}" }
    sequence(:subdomain) { |n| "project-#{n}" }
    description { "A project description." }
    current { nil }
  end
end

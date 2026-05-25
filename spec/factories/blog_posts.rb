FactoryBot.define do
  factory :blog_post do
    sequence(:title) { |n| "Blog Post #{n}" }
    content { "Some content here." }
    description { "A short description." }
  end
end

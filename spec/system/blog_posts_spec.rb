require "rails_helper"

RSpec.describe "Blog posts", type: :system do
  describe "index page" do
    it "lists all blog posts" do
      create_list(:blog_post, 3)
      visit blog_posts_path
      BlogPost.all.each do |post|
        expect(page).to have_text(post.title)
      end
    end

    it "links each post to its show page" do
      post = create(:blog_post)
      visit blog_posts_path
      click_link post.title
      expect(page).to have_current_path(blog_post_path(post))
    end
  end

  describe "show page" do
    it "displays the post title and content" do
      post = create(:blog_post, title: "My Post", content: "Hello world.")
      visit blog_post_path(post)
      expect(page).to have_text("My Post")
      expect(page).to have_text("Hello world.")
    end

    it "displays the formatted datetime" do
      post = create(:blog_post)
      visit blog_post_path(post)
      expect(page).to have_text(post.formatted_datetime)
    end
  end
end

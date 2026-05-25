require "rails_helper"

RSpec.describe "BlogPosts", type: :request do
  describe "GET /blog" do
    it "returns 200" do
      get blog_posts_path
      expect(response).to have_http_status(:ok)
    end

    it "lists all blog posts" do
      create_list(:blog_post, 3)
      get blog_posts_path
      expect(response.body).to include(*BlogPost.all.map(&:title))
    end
  end

  describe "GET /blog/:id" do
    it "returns 200" do
      blog_post = create(:blog_post)
      get blog_post_path(blog_post)
      expect(response).to have_http_status(:ok)
    end

    it "displays the blog post" do
      blog_post = create(:blog_post)
      get blog_post_path(blog_post)
      expect(response.body).to include(blog_post.title)
    end

    it "returns 404 for an unknown slug" do
      get blog_post_path("nonexistent-post")
      expect(response).to have_http_status(:not_found)
    end
  end
end

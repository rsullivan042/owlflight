require "rails_helper"

RSpec.describe "Admin::BlogPosts", type: :request do
  describe "GET /admin/blog_posts" do
    it "returns 200" do
      get admin_blog_posts_path, headers: admin_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /admin/blog_posts/:id" do
    it "returns 200" do
      blog_post = create(:blog_post)
      get admin_blog_post_path(blog_post), headers: admin_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /admin/blog_posts/new" do
    it "returns 200" do
      get new_admin_blog_post_path, headers: admin_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /admin/blog_posts" do
    it "creates a blog post and redirects" do
      expect {
        post admin_blog_posts_path,
          params: { blog_post: { title: "New Post", content: "Content here.", description: "A description." } },
          headers: admin_headers
      }.to change(BlogPost, :count).by(1)
      expect(response).to redirect_to(admin_blog_post_path(BlogPost.last))
    end

    it "re-renders new on invalid params" do
      post admin_blog_posts_path,
        params: { blog_post: { title: nil } },
        headers: admin_headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /admin/blog_posts/:id/edit" do
    it "returns 200" do
      blog_post = create(:blog_post)
      get edit_admin_blog_post_path(blog_post), headers: admin_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /admin/blog_posts/:id" do
    it "updates the blog post and redirects" do
      blog_post = create(:blog_post)
      patch admin_blog_post_path(blog_post),
        params: { blog_post: { title: "Updated Title" } },
        headers: admin_headers
      expect(blog_post.reload.title).to eq("Updated Title")
      expect(response).to redirect_to(admin_blog_post_path(blog_post.reload))
    end

    it "re-renders edit on invalid params" do
      blog_post = create(:blog_post)
      patch admin_blog_post_path(blog_post),
        params: { blog_post: { title: nil } },
        headers: admin_headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /admin/blog_posts/:id" do
    it "destroys the blog post and redirects" do
      blog_post = create(:blog_post)
      expect {
        delete admin_blog_post_path(blog_post), headers: admin_headers
      }.to change(BlogPost, :count).by(-1)
      expect(response).to redirect_to(admin_blog_posts_path)
    end
  end
end

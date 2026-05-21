class BlogPostsController < ApplicationController
  def index
    @blog_posts = BlogPost.all.order(published_at: :desc)
  end

  def show
    @blog_post = BlogPost.find_by!(slug: params[:id])
  end
end

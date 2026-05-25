class Admin::BlogPostsController < Admin::BaseController
  def index
    @blog_posts = BlogPost.all.order(published_at: :desc)
  end

  def show
    @blog_post = BlogPost.find_by!(slug: params[:id])
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    @blog_post.published_at = Time.now
    if @blog_post.save
      redirect_to [ :admin, @blog_post ], notice: "Blog post created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @blog_post = BlogPost.find_by!(slug: params[:id])
  end

  def update
    @blog_post = BlogPost.find_by!(slug: params[:id])
    if @blog_post.update(blog_post_params)
      redirect_to [ :admin, @blog_post ], notice: "Blog post successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post = BlogPost.find_by!(slug: params[:id])
    @blog_post.destroy
    redirect_to admin_blog_posts_path, notice: "Blog post deleted successfully."
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :description)
  end
end

class ChangePublishedAtTypeInBlogPosts < ActiveRecord::Migration[8.0]
  def change
    change_column :blog_posts, :published_at, :datetime
  end
end

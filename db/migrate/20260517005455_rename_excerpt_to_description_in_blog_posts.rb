class RenameExcerptToDescriptionInBlogPosts < ActiveRecord::Migration[8.0]
  def change
    rename_column :blog_posts, :excerpt, :description
  end
end

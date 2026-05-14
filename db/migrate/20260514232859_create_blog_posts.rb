class CreateBlogPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.string :slug
      t.text :content
      t.text :excerpt
      t.date :published_at

      t.timestamps
    end
  end
end

class BlogPost < ApplicationRecord
  before_validation :generate_slug

  validates :slug, uniqueness: true

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = title.parameterize if title.present?
  end
end

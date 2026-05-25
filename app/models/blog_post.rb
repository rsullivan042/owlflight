class BlogPost < ApplicationRecord
  before_validation :generate_slug
  before_create :set_published_at

  validates :title, presence: true
  validates :slug, uniqueness: true

  def to_param
    slug
  end

  def self.latest(limit = 3)
    order(created_at: :desc).limit(limit)
  end

  def formatted_date
    published_at.strftime("%b %d, %Y")
  end

  def formatted_datetime
    published_at.strftime("%b %d, %Y (%-l:%M %P)")
  end

  private

  def generate_slug
    self.slug = title.parameterize if title.present?
  end

  def set_published_at
    self.published_at ||= Time.current
  end
end

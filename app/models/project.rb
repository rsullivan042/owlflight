class Project < ApplicationRecord
  validates :name, presence: true
  validates :subdomain, presence: true, format: { with: /\A(none|[a-z0-9\-]+)\z/i }

  has_many :tasks, dependent: :destroy

  def tech_stack_input
    tech_stack.join(", ")
  end

  def tech_stack_input=(value)
    self.tech_stack = value.split(",").map(&:strip).reject(&:empty?)
  end

  def url
    if subdomain != "none"
      "https://#{subdomain}.owlflight.dev"
    else
      "https://owlflight.dev"
    end
  end

  # Class methods

  def self.current
    find_by(current: true)
  end

  def self.clear_current!(except: nil)
    scope = where(current: true)
    scope = scope.where.not(id: except.id) if except
    scope.update_all(current: false)
  end
end

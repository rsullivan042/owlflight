class Project < ApplicationRecord
  validates_presence_of :name, :subdomain

  has_many :tasks, dependent: :destroy

  def url
    if subdomain != "none"
      "https://#{subdomain}.owlflight.dev"
    else
      "https://owlflight.dev"
    end
  end

  def self.current
    find_by(current: true)
  end

  def self.clear_current!
    where(current: true).update_all(current: false)
  end
end

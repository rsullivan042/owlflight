class Project < ApplicationRecord
  validates_presence_of :name, :subdomain

  def url
    "https://#{subdomain}.owlflight.dev"
  end
end

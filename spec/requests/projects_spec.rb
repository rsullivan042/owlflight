require "rails_helper"

RSpec.describe "Projects", type: :request do
  describe "GET /projects" do
    it "returns 200" do
      get projects_path
      expect(response).to have_http_status(:ok)
    end

    it "lists all projects" do
      create_list(:project, 3)
      get projects_path
      expect(response.body).to include(*Project.all.map(&:name))
    end
  end
end

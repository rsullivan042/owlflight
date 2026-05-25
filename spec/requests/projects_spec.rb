require "rails_helper"

RSpec.describe "Projects", type: :request do
  describe "GET /projects/:id" do
    it "returns 200" do
      project = create(:project)
      get project_path(project)
      expect(response).to have_http_status(:ok)
    end

    it "displays the project name and description" do
      project = create(:project, description: "A great project.")
      get project_path(project)
      expect(response.body).to include(project.name, project.description)
    end

    it "displays the tech stack" do
      project = create(:project, tech_stack: ["Ruby on Rails", "PostgreSQL"])
      get project_path(project)
      expect(response.body).to include("Ruby on Rails", "PostgreSQL")
    end
  end

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

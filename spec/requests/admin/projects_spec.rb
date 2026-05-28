require "rails_helper"

RSpec.describe "Admin::Projects", type: :request do
  describe "GET /admin/projects" do
    it "returns 200" do
      get admin_projects_path, headers: admin_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /admin/projects/:id" do
    it "returns 200" do
      project = create(:project)
      get admin_project_path(project), headers: admin_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /admin/projects/new" do
    it "returns 200" do
      get new_admin_project_path, headers: admin_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /admin/projects" do
    it "creates a project and redirects" do
      expect {
        post admin_projects_path,
          params: { project: { name: "New Project", subdomain: "new-project" } },
          headers: admin_headers
      }.to change(Project, :count).by(1)
      expect(response).to redirect_to(admin_projects_path)
    end

    it "clears any existing current project when creating a current project" do
      existing = create(:project, current: true)
      post admin_projects_path,
        params: { project: { name: "New Project", subdomain: "new-project", current: true } },
        headers: admin_headers
      expect(existing.reload.current).to be_falsey
    end

    it "re-renders new on invalid params" do
      post admin_projects_path,
        params: { project: { name: nil, subdomain: nil } },
        headers: admin_headers
      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe "GET /admin/projects/:id/edit" do
    it "returns 200" do
      project = create(:project)
      get edit_admin_project_path(project), headers: admin_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /admin/projects/:id" do
    it "updates the project and redirects" do
      project = create(:project)
      patch admin_project_path(project),
        params: { project: { name: "Updated Name" } },
        headers: admin_headers
      expect(project.reload.name).to eq("Updated Name")
      expect(response).to redirect_to(admin_projects_path)
    end

    it "clears any existing current project when marking a project as current" do
      existing = create(:project, current: true)
      project = create(:project)
      patch admin_project_path(project),
        params: { project: { current: true } },
        headers: admin_headers
      expect(existing.reload.current).to be_falsey
    end

    it "re-renders edit on invalid params" do
      project = create(:project)
      patch admin_project_path(project),
        params: { project: { name: nil } },
        headers: admin_headers
      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe "DELETE /admin/projects/:id" do
    it "destroys the project and redirects" do
      project = create(:project)
      expect {
        delete admin_project_path(project), headers: admin_headers
      }.to change(Project, :count).by(-1)
      expect(response).to redirect_to(admin_projects_path)
    end
  end
end

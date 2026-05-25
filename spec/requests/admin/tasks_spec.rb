require "rails_helper"

RSpec.describe "Admin::Tasks", type: :request do
  let(:project) { create(:project) }

  describe "GET /admin/projects/:project_id/tasks/new" do
    it "returns 200" do
      get new_admin_project_task_path(project), headers: admin_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /admin/projects/:project_id/tasks" do
    it "creates a task and redirects to project" do
      expect {
        post admin_project_tasks_path(project),
          params: { task: { description: "New task" } },
          headers: admin_headers
      }.to change(project.tasks, :count).by(1)
      expect(response).to redirect_to(admin_project_path(project))
    end
  end

  describe "GET /admin/projects/:project_id/tasks/:id/edit" do
    it "returns 200" do
      task = create(:task, project: project)
      get edit_admin_project_task_path(project, task), headers: admin_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /admin/projects/:project_id/tasks/:id" do
    it "updates the task and redirects to project" do
      task = create(:task, project: project, description: "Old description")
      patch admin_project_task_path(project, task),
        params: { task: { description: "New description" } },
        headers: admin_headers
      expect(task.reload.description).to eq("New description")
      expect(response).to redirect_to(admin_project_path(project))
    end

    it "marks a task as completed" do
      task = create(:task, project: project, completed: false)
      patch admin_project_task_path(project, task),
        params: { task: { completed: true } },
        headers: admin_headers
      expect(task.reload.completed).to be true
    end
  end

  describe "DELETE /admin/projects/:project_id/tasks/:id" do
    it "destroys the task and redirects to project" do
      task = create(:task, project: project)
      expect {
        delete admin_project_task_path(project, task), headers: admin_headers
      }.to change(Task, :count).by(-1)
      expect(response).to redirect_to(admin_project_path(project))
    end
  end
end

require "rails_helper"

RSpec.describe "Projects", type: :system do
  describe "index page" do
    it "shows all projects" do
      create_list(:project, 3)
      visit projects_path
      Project.all.each do |project|
        expect(page).to have_text(project.name)
      end
    end

    it "links each project to its show page" do
      project = create(:project)
      visit projects_path
      expect(page).to have_link(project.name, href: project_path(project))
    end
  end

  describe "show page" do
    it "displays the project name and description" do
      project = create(:project, description: "A great project.")
      visit project_path(project)
      expect(page).to have_text(project.name)
      expect(page).to have_text(project.description)
    end

    it "displays the tech stack" do
      project = create(:project, tech_stack: ["Ruby on Rails", "PostgreSQL"])
      visit project_path(project)
      expect(page).to have_text("Ruby on Rails")
      expect(page).to have_text("PostgreSQL")
    end

    it "links to the external project URL" do
      project = create(:project, subdomain: "myapp")
      visit project_path(project)
      expect(page).to have_link("Visit Project →", href: project.url)
    end
  end
end

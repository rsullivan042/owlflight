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

    it "links each project to its external URL" do
      project = create(:project, subdomain: "myapp")
      visit projects_path
      expect(page).to have_link(project.name, href: project.url)
    end
  end
end

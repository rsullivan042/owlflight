require "rails_helper"

RSpec.describe Project, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      expect(build(:project)).to be_valid
    end

    it "is invalid without a name" do
      expect(build(:project, name: nil)).not_to be_valid
    end

    it "is invalid without a subdomain" do
      expect(build(:project, subdomain: nil)).not_to be_valid
    end
  end

  describe "associations" do
    it "destroys associated tasks when destroyed" do
      project = create(:project)
      create(:task, project: project)
      expect { project.destroy }.to change(Task, :count).by(-1)
    end
  end

  describe "#url" do
    it "returns the full subdomain URL when subdomain is set" do
      project = build(:project, subdomain: "myapp")
      expect(project.url).to eq("https://myapp.owlflight.dev")
    end

    it "returns the root URL when subdomain is 'none'" do
      project = build(:project, subdomain: "none")
      expect(project.url).to eq("https://owlflight.dev")
    end
  end

  describe ".current" do
    it "returns the project marked as current" do
      project = create(:project, current: true)
      create(:project)
      expect(Project.current).to eq(project)
    end

    it "returns nil when no project is current" do
      create(:project)
      expect(Project.current).to be_nil
    end
  end

  describe ".clear_current!" do
    it "sets current to false for all current projects" do
      create(:project, current: true)
      Project.clear_current!
      expect(Project.current).to be_nil
    end

    it "does not affect non-current projects" do
      project = create(:project)
      Project.clear_current!
      expect(project.reload.current).to be_nil
    end
  end
end

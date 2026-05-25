require "rails_helper"

RSpec.describe Task, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      expect(build(:task)).to be_valid
    end

    it "is invalid without a project" do
      expect(build(:task, project: nil)).not_to be_valid
    end
  end

  describe "defaults" do
    it "defaults completed to false" do
      task = create(:task)
      expect(task.completed).to be false
    end
  end

  describe "associations" do
    it "belongs to a project" do
      task = create(:task)
      expect(task.project).to be_a(Project)
    end
  end
end

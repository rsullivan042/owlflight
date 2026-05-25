require "rails_helper"

RSpec.describe "Home page", type: :system do
  it "shows the welcome heading" do
    visit root_path
    expect(page).to have_text("Welcome to OwlFlight!")
  end

  context "when there is a current project" do
    let!(:project) { create(:project, current: true, description: "Building something cool.") }

    it "shows the current project name and description" do
      visit root_path
      expect(page).to have_text(project.name)
      expect(page).to have_text(project.description)
    end

    it "shows tasks for the current project" do
      create(:task, project: project, description: "Write tests", completed: false)
      create(:task, project: project, description: "Deploy app", completed: true)
      visit root_path
      expect(page).to have_text("Write tests")
      expect(page).to have_text("Deploy app")
    end
  end

  context "when there is no current project" do
    it "shows the no current project message" do
      visit root_path
      expect(page).to have_text("No current project selected.", count: 2)
    end
  end

  context "with recent blog posts" do
    it "shows the latest blog posts" do
      create_list(:blog_post, 3)
      visit root_path
      BlogPost.latest.each do |post|
        expect(page).to have_text(post.title)
      end
    end

    it "links each blog post title to its show page" do
      post = create(:blog_post)
      visit root_path
      expect(page).to have_link(post.title, href: blog_post_path(post))
    end
  end
end

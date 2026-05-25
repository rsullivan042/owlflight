require "rails_helper"

RSpec.describe "Navigation", type: :system do
  it "shows all nav links" do
    visit root_path
    expect(page).to have_link("Home")
    expect(page).to have_link("Projects")
    expect(page).to have_link("Blog")
    expect(page).to have_link("About Me")
  end

  it "navigates to each page from the navbar" do
    visit root_path
    click_link "Projects"
    expect(page).to have_current_path(projects_path)

    click_link "Blog"
    expect(page).to have_current_path(blog_posts_path)

    click_link "About Me"
    expect(page).to have_current_path(about_me_path)

    click_link "Home"
    expect(page).to have_current_path(root_path)
  end
end

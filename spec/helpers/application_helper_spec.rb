require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#navbar_links" do
    it "returns links for all four main pages" do
      links = helper.navbar_links
      expect(links.map { |l| l[:text] }).to eq(["Home", "Projects", "Blog", "About Me"])
    end

    it "uses the correct paths" do
      links = helper.navbar_links
      expect(links.find { |l| l[:text] == "Home" }[:path]).to eq(root_path)
      expect(links.find { |l| l[:text] == "Projects" }[:path]).to eq(projects_path)
      expect(links.find { |l| l[:text] == "Blog" }[:path]).to eq(blog_posts_path)
      expect(links.find { |l| l[:text] == "About Me" }[:path]).to eq(about_me_path)
    end
  end

  describe "#admin_navbar_links" do
    it "returns the admin links" do
      links = helper.admin_navbar_links
      expect(links.map { |l| l[:text] }).to eq(["Dashboard", "Projects", "Blog", "Main Site"])
    end
  end

  describe "#nav_link_classes" do
    it "returns active classes for the current page" do
      allow(helper).to receive(:current_page?).and_return(true)
      expect(helper.nav_link_classes("/")).to include("text-amber-300", "border-amber-400")
    end

    it "returns inactive classes for other pages" do
      allow(helper).to receive(:current_page?).and_return(false)
      expect(helper.nav_link_classes("/projects")).to include("button_top_inactive", "text-stone-400")
    end

    it "always includes the base class" do
      allow(helper).to receive(:current_page?).and_return(false)
      expect(helper.nav_link_classes("/projects")).to include("button_top")
    end
  end

  describe "#safe_external_url" do
    it "returns the URL for valid https URLs" do
      expect(helper.safe_external_url("https://example.com")).to eq("https://example.com")
    end

    it "returns the URL for valid http URLs" do
      expect(helper.safe_external_url("http://example.com")).to eq("http://example.com")
    end

    it "returns # for javascript: URLs" do
      expect(helper.safe_external_url("javascript:alert(1)")).to eq("#")
    end

    it "returns # for invalid URLs" do
      expect(helper.safe_external_url("not a url")).to eq("#")
    end
  end

  describe "#markdown" do
    it "renders markdown to HTML" do
      expect(helper.markdown("**bold**")).to include("<strong>bold</strong>")
    end

    it "renders fenced code blocks" do
      input = "```\nputs 'hello'\n```"
      expect(helper.markdown(input)).to include("<code>")
    end

    it "renders tables" do
      input = "| a | b |\n|---|---|\n| 1 | 2 |"
      expect(helper.markdown(input)).to include("<table>")
    end

    it "renders strikethrough" do
      expect(helper.markdown("~~struck~~")).to include("<del>struck</del>")
    end

    it "strips raw HTML tags" do
      expect(helper.markdown("<script>alert('xss')</script>")).not_to include("<script>")
    end
  end
end

require "rails_helper"

RSpec.describe BlogPost, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      blog_post = build(:blog_post)
      expect(blog_post).to be_valid
    end

    it "is invalid without a title" do
      blog_post = build(:blog_post, title: nil)
      expect(blog_post).not_to be_valid
    end

    it "requires a unique slug" do
      create(:blog_post, title: "My Post")
      duplicate = build(:blog_post, title: "My Post")
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:slug]).to be_present
    end
  end

  describe "callbacks" do
    describe "#generate_slug" do
      it "generates a slug from the title before validation" do
        blog_post = build(:blog_post, title: "Hello World")
        blog_post.valid?
        expect(blog_post.slug).to eq("hello-world")
      end

      it "parameterizes the title into a slug" do
        blog_post = build(:blog_post, title: "Rails & Ruby: A Love Story!")
        blog_post.valid?
        expect(blog_post.slug).to eq("rails-ruby-a-love-story")
      end
    end

    describe "#set_published_at" do
      it "sets published_at to the current time on create" do
        travel_to Time.current do
          blog_post = create(:blog_post)
          expect(blog_post.published_at).to eq(Time.current)
        end
      end

      it "does not overwrite an existing published_at" do
        travel_to 1.week.ago do
          blog_post = create(:blog_post, published_at: Time.current)
          expect(blog_post.published_at).to eq(Time.current)
        end
      end
    end
  end

  describe "#to_param" do
    it "returns the slug" do
      blog_post = create(:blog_post, title: "My Post")
      expect(blog_post.to_param).to eq("my-post")
    end
  end

  describe ".latest" do
    it "returns posts ordered by created_at descending" do
      old_post = create(:blog_post)
      new_post = create(:blog_post)
      expect(BlogPost.latest.first).to eq(new_post)
    end

    it "limits to 3 by default" do
      create_list(:blog_post, 5)
      expect(BlogPost.latest.count).to eq(3)
    end

    it "accepts a custom limit" do
      create_list(:blog_post, 5)
      expect(BlogPost.latest(5).count).to eq(5)
    end
  end

  describe "#formatted_date" do
    it "formats published_at as 'Mon DD, YYYY'" do
      blog_post = build(:blog_post, published_at: Time.zone.parse("2026-01-15 10:00:00"))
      expect(blog_post.formatted_date).to eq("Jan 15, 2026")
    end
  end

  describe "#formatted_datetime" do
    it "formats published_at with date and 12-hour time" do
      blog_post = build(:blog_post, published_at: Time.zone.parse("2026-01-15 14:30:00"))
      expect(blog_post.formatted_datetime).to eq("Jan 15, 2026 (2:30 pm)")
    end
  end
end

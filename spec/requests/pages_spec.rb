require "rails_helper"

RSpec.describe "Pages", type: :request do
  describe "GET /" do
    it "returns 200" do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /about_me" do
    it "returns 200" do
      get about_me_path
      expect(response).to have_http_status(:ok)
    end
  end
end

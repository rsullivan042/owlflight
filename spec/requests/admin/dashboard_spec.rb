require "rails_helper"

RSpec.describe "Admin::Dashboard", type: :request do
  describe "GET /admin" do
    it "returns 200 with valid credentials" do
      get admin_root_path, headers: admin_headers
      expect(response).to have_http_status(:ok)
    end

    it "returns 401 without credentials" do
      get admin_root_path
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

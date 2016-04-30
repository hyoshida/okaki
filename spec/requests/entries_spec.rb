require 'rails_helper'

RSpec.describe "Entries", type: :request do
  describe "GET /users/:user_name:/entries" do
    it "works! (now write some real specs)" do
      user = create(:user)
      get user_entries_path(user)
      expect(response).to have_http_status(200)
    end
  end
end

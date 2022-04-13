require 'rails_helper'

RSpec.describe "ProdDestinations", type: :request do
  describe "GET /prod_destinations" do
    it "works! (now write some real specs)" do
      get prod_destinations_path
      expect(response).to have_http_status(200)
    end
  end
end

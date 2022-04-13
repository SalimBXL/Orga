require 'rails_helper'

RSpec.describe "ProdUnits", type: :request do
  describe "GET /prod_units" do
    it "works! (now write some real specs)" do
      get prod_units_path
      expect(response).to have_http_status(200)
    end
  end
end

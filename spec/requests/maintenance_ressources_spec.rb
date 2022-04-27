require 'rails_helper'

RSpec.describe "MaintenanceRessources", type: :request do
  describe "GET /maintenance_ressources" do
    it "works! (now write some real specs)" do
      get maintenance_ressources_path
      expect(response).to have_http_status(200)
    end
  end
end

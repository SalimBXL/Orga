require "rails_helper"

RSpec.describe MaintenanceRessourcesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/maintenance_ressources").to route_to("maintenance_ressources#index")
    end

    it "routes to #new" do
      expect(:get => "/maintenance_ressources/new").to route_to("maintenance_ressources#new")
    end

    it "routes to #show" do
      expect(:get => "/maintenance_ressources/1").to route_to("maintenance_ressources#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/maintenance_ressources/1/edit").to route_to("maintenance_ressources#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/maintenance_ressources").to route_to("maintenance_ressources#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/maintenance_ressources/1").to route_to("maintenance_ressources#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/maintenance_ressources/1").to route_to("maintenance_ressources#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/maintenance_ressources/1").to route_to("maintenance_ressources#destroy", :id => "1")
    end
  end
end

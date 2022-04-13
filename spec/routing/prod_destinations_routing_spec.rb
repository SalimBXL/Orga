require "rails_helper"

RSpec.describe ProdDestinationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/prod_destinations").to route_to("prod_destinations#index")
    end

    it "routes to #new" do
      expect(:get => "/prod_destinations/new").to route_to("prod_destinations#new")
    end

    it "routes to #show" do
      expect(:get => "/prod_destinations/1").to route_to("prod_destinations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/prod_destinations/1/edit").to route_to("prod_destinations#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/prod_destinations").to route_to("prod_destinations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/prod_destinations/1").to route_to("prod_destinations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/prod_destinations/1").to route_to("prod_destinations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/prod_destinations/1").to route_to("prod_destinations#destroy", :id => "1")
    end
  end
end

require "rails_helper"

RSpec.describe ProdUnitsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/prod_units").to route_to("prod_units#index")
    end

    it "routes to #new" do
      expect(:get => "/prod_units/new").to route_to("prod_units#new")
    end

    it "routes to #show" do
      expect(:get => "/prod_units/1").to route_to("prod_units#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/prod_units/1/edit").to route_to("prod_units#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/prod_units").to route_to("prod_units#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/prod_units/1").to route_to("prod_units#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/prod_units/1").to route_to("prod_units#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/prod_units/1").to route_to("prod_units#destroy", :id => "1")
    end
  end
end

require "rails_helper"

RSpec.describe TraceursController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/traceurs").to route_to("traceurs#index")
    end

    it "routes to #new" do
      expect(:get => "/traceurs/new").to route_to("traceurs#new")
    end

    it "routes to #show" do
      expect(:get => "/traceurs/1").to route_to("traceurs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/traceurs/1/edit").to route_to("traceurs#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/traceurs").to route_to("traceurs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/traceurs/1").to route_to("traceurs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/traceurs/1").to route_to("traceurs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/traceurs/1").to route_to("traceurs#destroy", :id => "1")
    end
  end
end

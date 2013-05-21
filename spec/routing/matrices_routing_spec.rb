require "spec_helper"

describe MatricesController do
  describe "routing" do

    it "routes to #index" do
      get("/matrices").should route_to("matrices#index")
    end

    it "routes to #new" do
      get("/matrices/new").should route_to("matrices#new")
    end

    it "routes to #show" do
      get("/matrices/1").should route_to("matrices#show", :id => "1")
    end

    it "routes to #edit" do
      get("/matrices/1/edit").should route_to("matrices#edit", :id => "1")
    end

    it "routes to #create" do
      post("/matrices").should route_to("matrices#create")
    end

    it "routes to #update" do
      put("/matrices/1").should route_to("matrices#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/matrices/1").should route_to("matrices#destroy", :id => "1")
    end

  end
end

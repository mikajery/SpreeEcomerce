require "spec_helper"

describe ClientAccountsController do
  describe "routing" do

    it "routes to #index" do
      get("/client_accounts").should route_to("client_accounts#index")
    end

    it "routes to #new" do
      get("/client_accounts/new").should route_to("client_accounts#new")
    end

    it "routes to #show" do
      get("/client_accounts/1").should route_to("client_accounts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/client_accounts/1/edit").should route_to("client_accounts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/client_accounts").should route_to("client_accounts#create")
    end

    it "routes to #update" do
      put("/client_accounts/1").should route_to("client_accounts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/client_accounts/1").should route_to("client_accounts#destroy", :id => "1")
    end

  end
end

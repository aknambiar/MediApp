require "rails_helper"

RSpec.describe ClientsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/clients/new").to route_to("clients#new")
    end

    it "routes to #show" do
      expect(get: "/clients/1").to route_to("clients#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/clients").to route_to("clients#create")
    end
  end
end

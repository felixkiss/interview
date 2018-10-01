require "rails_helper"

RSpec.describe PostsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(:get => "/posts/1").to route_to("posts#show", id: "1")
    end

    it "routes to #show in json format" do
      expect(:get => "/posts/1.json").to route_to("posts#show", id: "1", format: "json")
    end

    it "routes to #show in xml format" do
      expect(:get => "/posts/1.xml").to route_to("posts#show", id: "1", format: "xml")
    end
  end
end

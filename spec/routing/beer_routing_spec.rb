require "rails_helper"

RSpec.describe BeersController, type: :routing do
  describe "routing" do
    it "routes to beers successfully" do
      expect(get: "/beer/IPA").to route_to("beers#show", type: "IPA")
    end
  end
end

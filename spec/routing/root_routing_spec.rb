require "rails_helper"

RSpec.describe "root", type: :routing do
  describe "routing" do
    it "routes root to posts#index" do
      expect(:get => "/").to route_to("posts#index")
    end
  end
end

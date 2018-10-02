require 'rails_helper'

RSpec.describe BeersController, type: :controller do
  describe "GET #show" do
    it "returns content for IPA" do
      get :show, params: {type: "IPA"}
      expect(response).to have_http_status(:ok)
    end

    it "returns 404 for unknown beer type" do
      get :show, params: {type: "unknown"}
      expect(response).to have_http_status(:not_found)
    end
  end
end

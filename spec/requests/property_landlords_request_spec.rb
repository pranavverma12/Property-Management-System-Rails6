require 'rails_helper'

RSpec.describe "PropertyLandlords", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/property_landlords/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/property_landlords/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/property_landlords/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/property_landlords/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end

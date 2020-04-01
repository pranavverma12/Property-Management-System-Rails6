require 'rails_helper'

RSpec.describe "PropertyTenants", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/property_tenants/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/property_tenants/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/property_tenants/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end

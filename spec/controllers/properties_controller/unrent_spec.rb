# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:landlord) { create(:landlord) }
  let(:params) { {} }

  describe 'GET #unrent' do
    subject { get :unrent, params: params, session: session }

    let!(:property) { create(:property, landlord_email: landlord.email) }
    let(:tenant) { create(:tenant, property_id: property.id) }
    let(:params) { { id: property.id } }

    it 'assigns @property' do
      property.reload
      tenant.reload
      subject
      expect(assigns(:property)).to eq property
    end

    it 'unrented the Property' do
      tenant.reload
      subject
      property.reload

      expect(property.tenant_id).to eq nil
      expect(property.tenancy_start_date).to eq nil
      expect(property.tenancy_monthly_rent).to eq nil
      expect(property.tenancy_security_deposit).to eq nil
      expect(property.rented).to eq false      
    end

    it 'redirects to properties#show' do
      property.reload
      tenant.reload
      subject
      expect(response).to redirect_to Property.last
    end

    it 'decreasing the tenants count' do
      property.reload
      tenant.reload
      subject
      expect(property.tenants.count).to eq(0)
    end

    it 'assigns flash success' do
      property.reload
      tenant.reload
      subject
      expect(flash[:success]).to eq 'Property was successfully unrented.'
    end

    context 'when user is not logged in' do
      subject { get :edit, params: params, session: {} }

      it 'returns http forbidden status' do
        subject
        expect(response).to have_http_status(:forbidden)
      end

      it 'renders error page' do
        subject
        expect(response).to render_template('errors/not_authorized')
      end
    end
  end
end

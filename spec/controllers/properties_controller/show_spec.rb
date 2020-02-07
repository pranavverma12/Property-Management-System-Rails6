# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:landlord) { create(:landlord) }
  let(:tenant) { create(:tenant) }
  let(:params) { {} }

  describe 'GET #show without tenants' do
    subject { get :show, params: params, session: session }

    let!(:property) { create(:property, landlord_email: landlord.email) }
    let(:params) { { id: property.id } }

    it 'assigns @property' do
      subject
      expect(assigns(:property)).to eq property
    end

    it 'responds with 200 OK' do
      subject
      expect(response).to have_http_status(:ok)
    end

    context 'when user is not logged in' do
      subject { get :show, params: params, session: {} }

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

  describe 'GET #show with tenants' do
    subject { get :show, params: params, session: session }

    let!(:property) { create(:property, 
                              landlord_email: landlord.email, 
                              tenants_emails: tenant.email,
                              rented: true,
                              tenancy_security_deposit: 1500,
                              tenancy_monthly_rent: 1500,
                              tenancy_start_date: '07/02/2020') }
    
    let(:params) { { id: property.id } }

    it 'assigns @property' do
      subject
      expect(assigns(:property)).to eq property
    end

    it 'responds with 200 OK' do
      subject
      expect(response).to have_http_status(:ok)
    end

    context 'when user is not logged in' do
      subject { get :show, params: params, session: {} }

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

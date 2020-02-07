# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:landlord) { create(:landlord) }
  let(:params) { {} }

  describe 'GET #index' do
    subject { get :index, params: params, session: session }

    let!(:property1) { create(:property, landlord_email: landlord.email) }
    let!(:property2) { create(:property, landlord_email: landlord.email) }

    it 'assigns @properties' do
      subject
      expect(assigns(:properties)).to match_array [property1, property2]
    end

    it 'responds with 200 OK' do
      subject
      expect(response).to have_http_status(:ok)
    end

    context 'when user is not logged in' do
      subject { get :index, params: params, session: {} }

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

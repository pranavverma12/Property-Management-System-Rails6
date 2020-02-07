# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LandlordsController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:params) { {} }

  describe 'GET #show' do
    subject { get :show, params: params, session: session }

    let!(:landlord) { create(:landlord) }
    let(:params) { { id: landlord.id } }

    it 'assigns @landlord' do
      subject
      expect(assigns(:landlord)).to eq landlord
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

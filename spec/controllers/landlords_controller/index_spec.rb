# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LandlordsController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:params) { {} }

  describe 'GET #index' do
    subject { get :index, params: params, session: session }

    let!(:landlord1) { create(:landlord) }
    let!(:landlord2) { create(:landlord) }

    it 'assigns @landlords' do
      subject
      expect(assigns(:landlords)).to match_array [landlord1, landlord2]
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

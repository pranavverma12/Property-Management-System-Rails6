# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TenantsController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:params) { {} }

  describe 'GET #edit' do
    subject { get :edit, params: params, session: session }

    let!(:tenant) { create(:tenant) }
    let(:params) { { id: tenant.id } }

    it 'assigns @tenant' do
      subject
      expect(assigns(:tenant)).to eq tenant
    end

    it 'responds with 200 OK' do
      subject
      expect(response).to have_http_status(:ok)
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

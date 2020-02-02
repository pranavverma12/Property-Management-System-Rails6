# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:current_user) { create(:user) }
  let(:valid_session) { { user_id: current_user.id } }
  let(:params) { {} }

  describe 'GET #show' do
    subject { get :show, params: params, session: valid_session }

    let!(:user) { create(:user) }
    let(:params) { { id: user.id } }

    it 'assigns @user' do
      subject
      expect(assigns(:user)).to eq user
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

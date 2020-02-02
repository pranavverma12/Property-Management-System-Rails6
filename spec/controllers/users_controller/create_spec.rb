# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:current_user) { create(:user) }
  let(:valid_session) { { user_id: current_user.id } }
  let(:params) { {} }

  describe 'POST #create' do
    subject { post :create, params: params, session: valid_session }

    context 'when valid user param attributes' do
      let(:valid_user_attributes) do
        {
          username: 'lkasnvnslkdj',
          password: 'very_very_very_strong_password',
          password_confirmation: 'very_very_very_strong_password'
        }
      end

      let(:params) { { user: valid_user_attributes } }

      it 'assigns @user' do
        subject
        expect(assigns(:user)).to be_a User
      end

      it 'creates a User' do
        expect { subject }.to change(User, :count).by(1)

        user = User.last

        expect(user.username).to eq valid_user_attributes[:username]
      end

      it 'responds with 302 Found' do
        subject
        expect(response).to have_http_status(:found)
      end

      it 'redirects to users#show' do
        subject
        expect(response).to redirect_to User.last
      end

      it 'assigns flash success' do
        subject
        expect(flash[:success]).to eq 'User was successfully created.'
      end
    end

    context 'when invalid user param attributes' do
      let(:invalid_user_attributes) do
        {
          username: '',
          password: '',
          password_confirmation: ''
        }
      end

      let(:params) { { user: invalid_user_attributes } }

      it 'does not create a User' do
        expect { subject }.to_not change(User, :count)
      end

      it 'responds with unprocessable_entity' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user is not logged in' do
      subject { post :create, params: params, session: {} }

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

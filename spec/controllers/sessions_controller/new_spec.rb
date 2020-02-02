# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    describe 'when user is logged in' do
      let(:current_user) { create(:user) }

      before(:each) do
        session[:user_id] = current_user.id
        get :new
      end

      it 'returns http redirect status' do
        expect(response).to have_http_status(:found)
      end

      it 'redirects to users#show current_user' do
        expect(response).to redirect_to user_url(current_user)
      end

      it 'has flash notice "You are already Logged In" message' do
        expect(flash[:notice]).to be_present

        expect(flash[:notice]).to eq I18n.t(:already_logged_in, username: current_user.username)
      end
    end

    describe 'when user is not logged in' do
      before(:each) do
        get :new
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end

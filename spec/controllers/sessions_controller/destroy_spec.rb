# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'Delete #destroy' do
    describe 'when user is logged in' do
      let(:current_user) { create(:user) }

      before(:each) do
        session[:user_id] = current_user.id
        delete :destroy
      end

      it 'user session is destroyed' do
        expect(session[:user_id]).to be_nil
      end

      it 'user is redirected to login page' do
        expect(response).to redirect_to login_url
      end

      it 'flash notice shows logout success message' do
        expect(flash[:notice]).to be_present

        expect(flash[:notice]).to eq I18n.t(:logout_success)
      end
    end

    describe 'when user is not logged in' do
      before(:each) do
        delete :destroy
      end

      it 'returns http forbidden status' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'renders error page' do
        expect(response).to render_template('errors/not_authorized')
      end
    end
  end
end

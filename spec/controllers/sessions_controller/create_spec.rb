# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    let(:password) { 'superSecurePassword' }

    let(:current_user) { create(:user, password: password) }

    let(:params) { { username: current_user.username, password: password } }

    describe 'when user is logged in' do
      let(:current_user) { create(:user) }

      before(:each) do
        post :create, params: params, session: { user_id: current_user.id }
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
        post :create, params: params
      end

      describe 'when params are correct' do
        let(:params) { { username: current_user.username, password: password } }

        it 'returns http redirect status' do
          expect(response).to have_http_status(:found)
        end

        it 'redirects to user show' do
          expect(response).to redirect_to user_url(current_user)
        end

        it 'has flash notice "You have logged in" message' do
          expect(flash[:success]).to eq I18n.t(:login_success, username: current_user.username)
        end

        it 'should store user id in session' do
          expect(session['user_id']).to eq(current_user.id)
        end
      end

      describe 'when params are missing' do
        describe 'when username is missing' do
          let(:params) { { username: '', password: password } }

          it 'returns http unprocessable status' do
            expect(response).to have_http_status(:unprocessable_entity)
          end

          it 'has flash error "username_cannnot_be_empty" message' do
            expect(flash[:error]).to eq I18n.t(:form_has_errors, scope: 'errors.messages')
          end

          it 'assigns error to errors[:username]' do
            expect(assigns(:session).errors[:username]).to eq I18n.t(:username_cannnot_be_empty,
                                                                     scope: 'errors.messages')
          end
        end

        describe 'when password is missing' do
          let(:params) { { username: current_user.username, password: '' } }

          it 'returns http unprocessable status' do
            expect(response).to have_http_status(:unprocessable_entity)
          end

          it 'has flash error "password_cannnot_be_empty" message' do
            expect(flash[:error]).to eq I18n.t(:form_has_errors, scope: 'errors.messages')
          end

          it 'assigns error to errors[:password]' do
            expect(assigns(:session).errors[:password]).to eq I18n.t(:password_cannnot_be_empty,
                                                                     scope: 'errors.messages')
          end
        end
      end

      describe 'when params are incorrect' do
        describe 'when username is incorrect' do
          let(:params) { { username: 'incorrect', password: password } }

          it 'returns http unauthorized status' do
            expect(response).to have_http_status(:unauthorized)
          end

          it 'has flash error "username_or_password_incorrect" message' do
            expect(flash[:error]).to eq I18n.t(:username_or_password_incorrect, scope: 'errors.messages')
          end
        end

        describe 'when password is incorrect' do
          let(:params) { { username: current_user.username, password: 'incorrect' } }

          it 'returns http unauthorized status' do
            expect(response).to have_http_status(:unauthorized)
          end

          it 'has flash error "username_or_password_incorrect" message' do
            expect(flash[:error]).to eq I18n.t(:username_or_password_incorrect, scope: 'errors.messages')
          end
        end
      end
    end
  end
end

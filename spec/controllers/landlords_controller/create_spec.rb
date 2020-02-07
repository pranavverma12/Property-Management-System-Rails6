# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LandlordsController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:params) { {} }

  describe 'POST #create' do
    subject { post :create, params: params, session: session }
    context 'when valid landlord param attributes' do
      let(:valid_attributes) do
        {
          first_name: 'somelandlordfirstname',
          last_name: 'somelandlordlastname',
          email: 'somelandlordemail@topfloor.ie'
        }
      end
      let(:params) { { landlord: valid_attributes } }

      it 'assigns @landlord' do
        subject
        expect(assigns(:landlord)).to be_a Landlord
      end

      it 'creates a Landlord' do
        expect { subject }.to change(Landlord, :count).by(1)

        landlord = Landlord.last

        expect(landlord.first_name).to eq valid_attributes[:first_name]
        expect(landlord.last_name).to eq valid_attributes[:last_name]
        expect(landlord.email).to eq valid_attributes[:email]
      end

      it 'responds with 302 Found' do
        subject
        expect(response).to have_http_status(:found)
      end

      it 'redirects to landlords#show' do
        subject
        expect(response).to redirect_to Landlord.last
      end

      it 'assigns flash success' do
        subject
        expect(flash[:success]).to eq I18n.t(:success_create,
                                             scope: 'controllers.landlords.messages',
                                             first_name: valid_attributes[:first_name],
                                             last_name: valid_attributes[:last_name],
                                             email: valid_attributes[:email])
      end
    end

    context 'when invalid landlord param attributes' do
      let(:invalid_attributes) { build(:landlord, first_name: '').attributes }
      let(:params) { { landlord: invalid_attributes } }

      it 'does not create a Landlord' do
        expect { subject }.to_not change(Landlord, :count)
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

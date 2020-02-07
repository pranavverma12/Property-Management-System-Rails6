# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TenantsController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:params) { {} }

  describe 'POST #create' do
    subject { post :create, params: params, session: session }

    context 'when valid tenant param attributes' do
      let(:valid_attributes) { build(:tenant).attributes }
      let(:params) { { tenant: valid_attributes } }

      it 'assigns @tenant' do
        subject
        expect(assigns(:tenant)).to be_a Tenant
      end

      it 'creates a Tenant' do
        expect { subject }.to change(Tenant, :count).by(1)

        tenant = Tenant.last

        expect(tenant.first_name).to eq valid_attributes['first_name']
        expect(tenant.last_name).to eq valid_attributes['last_name']
        expect(tenant.email).to eq valid_attributes['email']
      end

      it 'responds with 302 Found' do
        subject
        expect(response).to have_http_status(:found)
      end

      it 'redirects to tenants#show' do
        subject
        expect(response).to redirect_to Tenant.last
      end

      it 'assigns flash success' do
        subject
        expect(flash[:success]).to eq I18n.t(:success_create,
                                             scope: 'controllers.tenants.messages',
                                             first_name: valid_attributes['first_name'],
                                             last_name: valid_attributes['last_name'])
      end
    end

    context 'when invalid tenant param attributes' do
      let(:invalid_attributes) { build(:tenant, first_name: '').attributes }
      let(:params) { { tenant: invalid_attributes } }

      it 'does not create a Tenant' do
        expect { subject }.to_not change(Tenant, :count)
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

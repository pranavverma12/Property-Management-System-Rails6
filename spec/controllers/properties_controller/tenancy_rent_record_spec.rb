# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:landlord1) { create(:landlord) }
  let(:landlord2) { create(:landlord) }
  let(:tenant1) { create(:tenant) }
  let(:tenant2) { create(:tenant) }
  let(:params) { {} }

  describe 'GET #tenancy_rent_record' do
    context 'when user is logged in' do
      let!(:property1) { create(:property,
                                landlord_email: landlord1.email,
                                rented: true,
                                tenants_emails: tenant1.email,
                                tenancy_security_deposit: 1500,
                                tenancy_monthly_rent: 1500,
                                tenancy_start_date: '07/02/2020') }

      let!(:property2) { create(:property,
                                landlord_email: landlord2.email,
                                rented: true,
                                tenants_emails: tenant2.email,
                                tenancy_security_deposit: 1500,
                                tenancy_monthly_rent: 1500,
                                tenancy_start_date: '07/02/2020') }

      subject { get :tenancy_rent_record, params: params, session: session }


      it 'property is rented and have valid details' do
        subject
        expect(property1.rented).to eq true
        expect(property2.rented).to eq true
        expect(property1.tenancy_monthly_rent).not_to be nil
        expect(property2.tenancy_monthly_rent).not_to be nil
        expect(property1.tenancy_security_deposit).not_to be nil
        expect(property2.tenancy_security_deposit).not_to be nil
      end

      it 'tenants information is/are available' do
        tenant1.update(property_id: property1.id)
        tenant2.update(property_id: property2.id)
        
        subject

        expect(property1.alltenants.map(&:id)).to eq([tenant1.id])
        expect(property2.alltenants.map(&:id)).to eq([tenant2.id])
        expect(property1.alltenants.map(&:email)).to eq([tenant1.email])
        expect(property2.alltenants.map(&:email)).to eq([tenant2.email])
        expect(property1.alltenants.map(&:full_name)).to eq([tenant1.full_name])
        expect(property2.alltenants.map(&:full_name)).to eq([tenant2.full_name])
      end

      it 'responds with 200 OK' do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not logged in' do
      let(:current_user) { create(:user) }
      let(:session) { { user_id: current_user.id } }
      subject { get :tenancy_rent_record}

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

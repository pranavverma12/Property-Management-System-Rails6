# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
  let(:landlord1) { create(:landlord) }
  let(:landlord2) { create(:landlord) }
  let(:params) { {} }

  describe 'GET #advertised_monthly_rent' do
    context 'when user is not logged in' do
      subject { get :advertised_monthly_rent, params: params }

      let!(:property1) { create(:property, landlord_email: landlord1.email, rented: false, tenants_emails: nil, tenancy_start_date: nil) }
      let!(:property2) { create(:property, landlord_email: landlord2.email, rented: false, tenants_emails: nil, tenancy_start_date: nil) }

      it 'property is not rented and have valid details' do
        subject
        expect(property1.rented).to eq false
        expect(property2.rented).to eq false
        expect(property1.tenancy_start_date).to eq nil
        expect(property2.tenancy_start_date).to eq nil
        expect(property1.alltenants.map(&:emails)).to eq []
        expect(property2.alltenants.map(&:emails)).to eq []
      end

      it 'tenants information are not available' do
        subject

        expect(property1.alltenants.count).to eq 0
        expect(property2.alltenants.count).to eq 0
      end

      it 'responds with 200 OK' do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is logged in' do
      let(:current_user) { create(:user) }
      let(:session) { { user_id: current_user.id } }
      subject { get :advertised_monthly_rent, params: params, session: session }

      it 'responds with 200 OK' do
        subject
        expect(response).to have_http_status(:ok)
      end
    end
  end
end

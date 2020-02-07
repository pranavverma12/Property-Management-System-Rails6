# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PropertiesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/properties').to route_to('properties#index')
    end

    it 'routes to #new' do
      expect(get: '/properties/new').to route_to('properties#new')
    end

    it 'routes to #show' do
      expect(get: '/properties/1').to route_to('properties#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/properties/1/edit').to route_to('properties#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/properties').to route_to('properties#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/properties/1').to route_to('properties#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/properties/1').to route_to('properties#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/properties/1').to route_to('properties#destroy', id: '1')
    end

    it 'routes to #unrent' do
      expect(get: '/properties/1/unrent').to route_to('properties#unrent', id: '1')
    end

    it 'routes to #advertised_monthly_rent' do
      expect(get: '/properties/advertised_monthly_rent').to route_to('properties#advertised_monthly_rent')
    end

    it 'routes to #tenancy_rent_record' do
      expect(get: '/properties/tenancy_rent_record').to route_to('properties#tenancy_rent_record')
    end
  end
end

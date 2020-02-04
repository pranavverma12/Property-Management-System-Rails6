# frozen_string_literal: true

json.array! @landlords, partial: 'landlords/landlord', as: :landlord

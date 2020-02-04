# frozen_string_literal: true

json.extract! landlord, :id, :first_name, :last_name, :email, :created_at, :updated_at
json.url landlord_url(landlord, format: :json)

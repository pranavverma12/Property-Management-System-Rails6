# frozen_string_literal: true

class PropertyLandlord < ApplicationRecord
  belongs_to :property
  belongs_to :landlord
end

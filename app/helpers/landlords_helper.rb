# frozen_string_literal: true

module LandlordsHelper

  def update_property_details(landlord, previous_email)
    properties = Property.where(landlord_email: previous_email)
    properties&.each { |property| property.update!(landlord_email: landlord.email,
                                                  landlord_first_name: landlord.first_name,
                                                  landlord_last_name: landlord.last_name)
                                                  }
  end
end

# frozen_string_literal: true

module PropertiesHelper

  def landlords_email_list
    Landlord.all.map(&:email) || [Property.first.landlord_email]
  end

  def tenants_email_list
    Tenant.all.map(&:email)
  end
end

# frozen_string_literal: true

module PropertiesHelper

  def landlords_email_list
    Landlord.all.map(&:email) || [Property.first.landlord_email]
  end

  def tenants_email_list
    Tenant.all
  end

  def unrent_tenant_params
    {
      tenancy_start_date: nil,
      tenancy_security_deposit: nil,
      tenancy_monthly_rent: nil,
      rented: false,
      tenant_id: nil
    }
  end

  def rent_due_on(property)
    property&.tenancy_start_date&.strftime('%d').to_s + ' ' + Time.now.strftime('%B %Y').to_s
  end

  def update_tenants_details(property, tenant_email)
    unless property.tenants.empty?
      property.tenants.each do |t|
        t.update(property_id: nil)
      end
    end

    tenant = Tenant.find_by(email: tenant_email)
    if tenant.nil?
      tenant = nil
    else
      tenant.update(property_id: property.id)
    end

    tenant
  end
end

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
    property.tenants.each { |t| t.update(property_id: nil) } unless property.tenants.empty?

    tenant = Tenant.find_by(email: tenant_email)
    tenant.nil? ? nil : tenant.update(property_id: property.id)

    tenant
  end

  def check_tenancy_records(property, param, return_type)
    unless param[:tenant_id] != '' && (param[:tenancy_monthly_rent] == '' ||
                                       param[:tenancy_start_date] == '' ||
                                       param[:tenancy_security_deposit] == ''); return; end

    adding_custom_errors(property,
                         'tenancy_monthly_rent',
                         'Please rent the valid monthly rent for tenants') if param[:tenancy_monthly_rent] == ''
    adding_custom_errors(property,
                         'tenancy_start_date',
                         'Please rent the valid start date of tenants') if param[:tenancy_start_date] == ''
    adding_custom_errors(property,
                         'tenancy_security_deposit',
                         'Please rent the valid monthly rent for tenants') if param[:tenancy_security_deposit] == ''

    render return_type, status: :unprocessable_entity
  end
end

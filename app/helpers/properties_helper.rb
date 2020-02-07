# frozen_string_literal: true

module PropertiesHelper

  def landlords_email_list
    Landlord.all.map(&:email) || [Property.first.landlord_email]
  end

  def other_landlords_email_list(landlord_email)
    Landlord.where.not(email: landlord_email)
  end

  def landlords_details(property)
    landlords_email = (property.other_landlords_emails.to_s + "," + property.landlord_email).split(',')
    Property.other_landlords(landlords_email)
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
      tenants_emails: nil
    }
  end

  def rent_due_on(property) # to display the rent due date of the currrent month
    property&.tenancy_start_date&.strftime('%d').to_s + ' ' + Time.now.strftime('%B %Y').to_s
  end

  def update_tenants_details(property, tenant_emails)
    property.alltenants.each { |t| t.update(property_id: nil) } unless property.alltenants.empty?

    property.alltenants.each { |tenant|
                                tenant.nil? ? nil : tenant.update(property_id: property.id)
                              }

    property.update(rented: true) unless property.alltenants.map(&:email).blank?    
  end

  def check_tenancy_records(property, param, return_type)
    unless param[:tenants_emails] != '' && (param[:tenancy_monthly_rent] == '' ||
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

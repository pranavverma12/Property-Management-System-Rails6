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
    Tenant.all.map { |tenant| [tenant.email, tenant.id] }
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

  def update_tenants_details(property, values)
    property.update!(tenancy_start_date: values[:tenancy_start_date], 
                    tenancy_monthly_rent: values[:tenancy_monthly_rent],
                    tenancy_security_deposit: values[:tenancy_security_deposit],
                    rented: true
                  )
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

    render :new, status: :unprocessable_entity
  end
end

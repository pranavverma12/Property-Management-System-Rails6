# frozen_string_literal: true

module PropertiesHelper
  def landlords_email_list
    Landlord.all.map(&:email)
  end

  def other_landlords_email_list(property)
    landlords_list = Landlord.where.not(email: existing_landlords_details(property))
    unless landlords_list.empty?
      landlords_list = landlords_list.all.map { |landlord| [landlord.email, landlord.id] }
      landlords_list
    end
  end

  def existing_landlords_details(property)
    property.landlords.map(&:email)
  end

  def landlords_full_name(property)
    property.landlords.map(&:full_name).join(', ')
  end

  def landlords_emails(property)
    property.landlords.map(&:email).join(', ')
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
    if property&.tenancy_start_date&.strftime('%m').to_i <= Time.now.strftime('%m').to_i
      property&.tenancy_start_date&.strftime('%d').to_s + ' ' + Time.now.strftime('%B %Y').to_s
    else
      'Tenant has not come in the property yet.'
    end
  end

  def update_tenants_details(property, values)
    property.update!(tenancy_start_date: values[:tenancy_start_date],
                     tenancy_monthly_rent: values[:tenancy_monthly_rent],
                     tenancy_security_deposit: values[:tenancy_security_deposit],
                     rented: true)
  end

  def check_tenancy_records(property, param, _return_type)
    unless param[:tenants_emails] != '' && (param[:tenancy_monthly_rent] == '' ||
                                       param[:tenancy_start_date] == '' ||
                                       param[:tenancy_security_deposit] == '')
      return; end

    if param[:tenancy_monthly_rent] == ''
      adding_custom_errors(property,
                           'tenancy_monthly_rent',
                           'Please rent the valid monthly rent for tenants')
    end
    if param[:tenancy_start_date] == ''
      adding_custom_errors(property,
                           'tenancy_start_date',
                           'Please rent the valid start date of tenants')
    end
    if param[:tenancy_security_deposit] == ''
      adding_custom_errors(property,
                           'tenancy_security_deposit',
                           'Please rent the valid monthly rent for tenants')
    end

    render :new, status: :unprocessable_entity
  end

  def check_landlord_id(property, param, _return_type)
    if param[:property][:landlord_id].empty?
      adding_custom_errors(property,
                           'landlord_id',
                           'Please select the valid landlord')

      render :new, status: :unprocessable_entity
    end
  end
end

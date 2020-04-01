# frozen_string_literal: true

class PropertyTenantsController < ApplicationController
  include PropertiesHelper

  def new
    @property = Property.find(params[:id])
    @existing_property_tenants = @property.tenants
    @property_tenant = @property.property_tenants.new
  end

  def create
    @property = Property.find(params[:property_tenant][:property_id])
    @property_tenant = @property.property_tenants.new(property_id: params[:property_tenant][:property_id],
                                                      tenant_id: params[:property_tenant][:tenant_id])

    check_tenancy_records(@property_tenant, params[:property_tenant], 'new') # to check if valid tenancy details has been passed or not

    return unless @property_tenant.errors.messages.blank?

    if @property_tenant.save
      update_tenants_details(@property, params[:property_tenant])
      flash[:success] = "Tenants #{@property_tenant.tenant.full_name} has occupied the property."
      redirect_to @property
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def unrent
    @property_tenant = PropertyTenant.where(property_id: params[:property_id],
                                            tenant_id: params[:tenant_id]).first
    @property_tenant.delete

    flash[:notice] = 'Tenants has unoccupied the property.'
    redirect_back(fallback_location: root_path)
  end

  private

  def property_tenants_params
    params.require(:property_tenant).permit(:property_id, :tenant_id)
  end
end

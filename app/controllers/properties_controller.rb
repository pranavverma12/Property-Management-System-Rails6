# frozen_string_literal: true

class PropertiesController < ApplicationController
  include PropertiesHelper

  before_action :set_property, only: %i[show edit update destroy unrent]
  skip_before_action :authenticate_user!, only: %i[advertised_monthly_rent]

  def index
    @properties = Property.all
  end

  def show; end

  def new
    @property = Property.new
  end

  def edit; end

  def create
    @property = Property.new(property_params)

    if @property.save
      flash[:success] = 'Property was successfully created.'
      redirect_to @property
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @property.update(property_params)
      if params[:property][:tenant_email] != ''
        tenant = Tenant.find_by(email: params[:property][:tenant_email])
      
        unless tenant.nil?
          @property.update(tenant_id: tenant.id, rented: true)
          tenant.update(property_id: @property.id)
        end

      end

      flash[:success] = 'Property was successfully updated.'
      redirect_to @property
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy

    redirect_to properties_url, notice: 'Property was successfully destroyed.'
  end

  def unrent
    @property.tenants.first.update(property_id: nil)
    
    @property.update(unrent_tenant_params)
    flash[:success] = 'Property was successfully unrented.'
    redirect_to @property
  end

  def advertised_monthly_rent
    @properties = Property.where(rented: false)
  end

  def tenancy_rent_record
    @properties = Property.where(rented: true)
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def property_params
    params.require(:property).permit(
      :property_name,
      :property_address,
      :landlord_first_name,
      :landlord_last_name,
      :landlord_email,
      :tenancy_start_date,
      :tenancy_security_deposit,
      :tenancy_monthly_rent,
      :rented,
      :tenant_id
    )
  end
end

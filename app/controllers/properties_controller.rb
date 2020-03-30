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
    check_tenancy_records(@property, property_params, 'new') # to check if valid tenancy details has been passed or not

    return unless @property.errors.messages.blank?

    if @property.save
      flash[:success] = 'Property was successfully created.'
      redirect_to @property
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    check_tenancy_records(@property, property_params, 'edit') # to check if valid tenancy details has been passed or not

    return unless @property.errors.messages.blank?

    if @property.update(property_params)

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
      :tenancy_security_deposit,
      :tenancy_monthly_rent
    )
  end
end

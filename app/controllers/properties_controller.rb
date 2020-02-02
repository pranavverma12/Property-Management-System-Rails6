# frozen_string_literal: true

class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]

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

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(
      :property_name,
      :property_address,
      :landlord_first_name,
      :landlord_last_name,
      :landlord_email
    )
  end
end

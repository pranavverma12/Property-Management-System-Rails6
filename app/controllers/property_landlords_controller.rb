# frozen_string_literal: true

class PropertyLandlordsController < ApplicationController
  before_action :set_property, only: %i[new destroy]

  def new
    @existing_property_landlords = @property.landlords
    @property_landlord = @property.property_landlords.new
  end

  def create
    @property = Property.find(params[:property_landlord][:property_id])
    @property_landlord = @property.property_landlords.new(property_id: params[:property_landlord][:property_id],
                                                          landlord_id: params[:property_landlord][:landlord_id])

    if @property_landlord.save
      flash[:success] = "Landlords #{@property_landlord.landlord.full_name} is assigned as a new owner of the property."
      redirect_to @property
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update; end

  def destroy
    if @property.property_landlords.count != 1
      @property_landlord = PropertyLandlord.where(property_id: params[:id],
                                                  landlord_id: params[:landlord_id]).first
      @property_landlord.delete

      flash[:notice] = 'Landlord has been deleted from owner position of this property.'
    else
      flash[:error] = 'Cannot delete the only owner from the property.'
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end
end

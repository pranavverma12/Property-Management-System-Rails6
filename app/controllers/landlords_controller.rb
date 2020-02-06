# frozen_string_literal: true

class LandlordsController < ApplicationController

  include LandlordsHelper

  before_action :set_landlord, only: %i[show edit update destroy]

  def index
    @landlords = Landlord.all
  end

  def show; end

  def new
    @landlord = Landlord.new
  end

  def edit; end

  def create
    @landlord = Landlord.new(landlord_params)

    if @landlord.save
      flash[:success] = I18n.t(:success_create,
                               scope: 'controllers.landlords.messages',
                               first_name: @landlord.first_name,
                               last_name: @landlord.last_name,
                               email: @landlord.email)

      redirect_to @landlord
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    previous_email = @landlord.email

    if @landlord.update(landlord_params)
      update_property_details(@landlord, previous_email)

      flash[:success] = I18n.t(:success_update,
                               scope: 'controllers.landlords.messages',
                               first_name: @landlord.first_name,
                               last_name: @landlord.last_name,
                               email: @landlord.email)

      redirect_to @landlord
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @landlord.destroy
    redirect_to landlords_url, notice: 'Landlord was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_landlord
    @landlord = Landlord.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def landlord_params
    params.require(:landlord).permit(:first_name, :last_name, :email)
  end
end

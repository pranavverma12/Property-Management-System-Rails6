# frozen_string_literal: true

class TenantsController < ApplicationController
  before_action :set_tenant, only: %i[show edit update destroy]

  def index
    @tenants = Tenant.all
  end

  def show; end

  def new
    @tenant = Tenant.new
  end

  def edit; end

  def create
    @tenant = Tenant.new(tenant_params)

    if @tenant.save
      flash[:success] = I18n.t(:success_create,
                               scope: 'controllers.tenants.messages',
                               first_name: @tenant.first_name,
                               last_name: @tenant.last_name)

      redirect_to @tenant
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tenant.update(tenant_params)
      flash[:success] = I18n.t(:success_update,
                               scope: 'controllers.tenants.messages',
                               first_name: @tenant.first_name,
                               last_name: @tenant.last_name)

      redirect_to @tenant
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tenant.destroy

    redirect_to tenants_url, notice: 'Tenant was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tenant
    @tenant = Tenant.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tenant_params
    params.require(:tenant).permit(:first_name, :last_name, :email)
  end
end

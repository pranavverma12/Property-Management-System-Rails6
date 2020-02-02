# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'User was successfully created.'
      redirect_to @user
    else
      flash.now[:error] = I18n.t(:form_has_errors, scope: 'errors.messages')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User(#{@user.username}) was successfully updated."
      redirect_to @user
    else
      flash.now[:error] = I18n.t(:form_has_errors, scope: 'errors.messages')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy

    flash[:notice] = "User(#{@user.username}) was successfully destroyed."
    redirect_to users_url
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end

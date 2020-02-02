# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  before_action :set_session, only: %i[new create]

  before_action :set_user, only: %i[create]

  before_action :skip_if_logged_in, only: %i[new create]

  before_action :validate_form, only: %i[create]

  def new; end

  def create
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id

      flash[:success] = I18n.t(:login_success, username: @user.username)

      redirect_to @user
    else
      flash.now[:error] = I18n.t(:username_or_password_incorrect,
                                 scope: 'errors.messages')

      render :new, status: :unauthorized
    end
  end

  def destroy
    reset_session

    redirect_to login_url, notice: I18n.t(:logout_success)
  end

  private

  def set_session
    @session = OpenStruct.new(
      errors: {}.with_indifferent_access
    )
  end

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def skip_if_logged_in
    return unless current_user

    redirect_to current_user,
                notice: I18n.t(:already_logged_in,
                               username: current_user.username)
  end

  def validate_form
    validation_username_input
    validation_password_input

    return if @session.errors.blank?

    flash.now[:error] = I18n.t(:form_has_errors, scope: 'errors.messages')
    render :new, status: :unprocessable_entity
  end

  def validation_username_input
    return if params[:username].present?

    @session.errors[:username] = I18n.t(:username_cannnot_be_empty,
                                        scope: 'errors.messages')
  end

  def validation_password_input
    return if params[:password].present?

    @session.errors[:password] = I18n.t(:password_cannnot_be_empty,
                                        scope: 'errors.messages')
  end
end

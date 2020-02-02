# frozen_string_literal: true

class ApplicationController < ActionController::Base
  NotAuthorized = Class.new(StandardError)

  before_action :authenticate_user!

  helper_method :current_user

  # Catch unathorized errors and render error page
  rescue_from ApplicationController::NotAuthorized do |_exception|
    respond_to do |format|
      format.html do
        render template: 'errors/not_authorized',
               status: :forbidden,
               layout: true
      end
      format.any { head :forbidden }
    end
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate_user!
    raise ApplicationController::NotAuthorized if current_user.nil?
  end
end

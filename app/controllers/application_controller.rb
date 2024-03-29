# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when Teacher
      teacher_dashboard_path
    when Student
      student_dashboard_path
    end
  end

  protected

  def configure_permitted_parameters
    attributes = %i[name surname email]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end
end

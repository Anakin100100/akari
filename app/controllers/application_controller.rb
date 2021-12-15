# frozen_string_literal: true

class ApplicationController < ActionController::Base

    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
        if resource.is_a?(Teacher)
            teacher_dashboard_path # your path
        elsif resource.is_a?(Student)
            student_dashboard_path # your path
        end
    end

    protected

    def configure_permitted_parameters
        attributes = [:name, :surname, :email]
        devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
        devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    end

end

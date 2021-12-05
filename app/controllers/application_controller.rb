# frozen_string_literal: true

class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        if resource.is_a?(Teacher)
            teacher_dashboard_path # your path
        elsif resource.is_a?(Student)
            student_dashboard_path # your path
        end
    end
end

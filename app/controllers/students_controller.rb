# frozen_string_literal: true

class StudentsController < ApplicationController
    before_action :authenticate_student!

    def student_dashboard
    end
end
  
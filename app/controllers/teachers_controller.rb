# frozen_string_literal: true

class TeachersController < ApplicationController
  before_action :authenticate_teacher!

  def teacher_dashboard; end
end

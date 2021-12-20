# frozen_string_literal: true

class GroupProjectReferencesController < ApplicationController
    before_action :authenticate_teacher!

    def show
        @group_project_reference = GroupProjectReference.find(params[:id])
        @students = Project.where(group_project_reference_id: @group_project_reference.id).map(&:student)
    end
end

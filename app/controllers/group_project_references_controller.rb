# frozen_string_literal: true

class GroupProjectReferencesController < ApplicationController
    before_action :authenticate_teacher!

    def show
        @group_project_reference = GroupProjectReference.find(params[:id])
        @group = Group.find(@group_project_reference.group_id)
        @students = Project.where(group_project_reference_id: @group_project_reference.id).map(&:student)
    end

    def delete 
        @group_project_reference = GroupProjectReference.find(params[:id])
        @projects = Project.where(group_project_reference_id: @group_project_reference.id)
        @projects.each do |project|
            project.delete_all_resources
            project.destroy
        end
        @group = Group.find(@group_project_reference.group_id)
        @group_project_reference.destroy
        redirect_to group_path(@group)
    end
end

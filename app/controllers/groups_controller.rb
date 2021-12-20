# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :authenticate_teacher!

  def index
    @groups = Group.all.where(teacher_id: current_teacher.id)
  end

  def new; end

  def create
    if params['group']['name'] == ''
      flash["error"] = 'Nie można utworzyć grupy bez nazwy'
      redirect_to new_group_path
      return
    end

    if current_teacher.groups.where(name: params['group']['name']).count != 0
      flash["error"] = 'Grupa o takiej nazwie już istnieje'
    end
    @group = Group.new(name: params['group']['name'])
    @group.teacher_id = current_teacher.id
    invalid_names = []
    params['group']['students_names'].split("\r\n").each do |student_email|
      if Student.where(email: student_email).empty?
        invalid_names << student_email
      else
        @group.students << Student.where(email: student_email)
      end
    end
    if invalid_names.empty? == false
      flash[:Student_validation_error] =
        "The following students have invalid email addresses: #{invalid_names.join(', ')}"
      redirect_to new_group_path
      return
    end
    @group.save
    redirect_to groups_path
  end

  def show
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end
end

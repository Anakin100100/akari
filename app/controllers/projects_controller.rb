# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_teacher!

  def new; end

  def create
    @group = Group.find(params['project']['group_id'].to_i)

    if params['project']['name'] == ''
      flash["name can't be empty"] = 'Please enter a name'
      redirect_to new_project_path(group_id: @group.id)
      return
    end

    if params['project']['resource_definitions'] == ''
      flash["resource definitions can't be empty"] = 'Please enter resource definitions'
      redirect_to new_project_path(group_id: @group.id)
      return
    end

    cpu_limit = params['project']['cpu_limit']
    memory_limit = params['project']['memory_limit']
    # 0 means invalid input
    if cpu_limit.to_i <= 0 || memory_limit.to_i <= 0
      flash['Invalid cpu or memory limit'] = 'Please enter a valid number'
      redirect_to new_project_path(group_id: @group.id)
      return
    end
    reference = GroupProjectReference.new(
      name: params['project']['name'],
      group_id: @group.id
    )
    reference.save
    @group.students.each do |student|
      student_project = Project.new(
        name: "#{student.name}_#{student.surname}_#{@group.name}_#{params['project']['name']}",
        cpu_limit: params['project']['cpu_limit'].to_i,
        memory_limit: params['project']['memory_limit'].to_i,
        group_project_reference_id: reference.id
      )
      student_project.student_id = student.id
      student_project.save
    end
    flash['Project creation successful'] = 'The project has been created'
    redirect_to group_path(@group)
  end

  def show
    @project = Project.find(params['id'])
    group_project_reference = GroupProjectReference.find(@project.group_project_reference_id)
    group = Group.where(id: group_project_reference.group_id)
    if group.empty? 
       @group = "Brak grupy"
    else  
      @group = group.first.name
    end 
  end

  def edit  
    @project = Project.find(params['id'])
  end

  def update
    if params['project']['name'] == ''
      flash["name can't be empty"] = 'Please enter a name'
      redirect_to modify_project_path(id: params['id'])
      return
    end

    if params['project']['resource_definitions'] == ''
      flash["resource definitions can't be empty"] = 'Please enter resource definitions'
      redirect_to modify_project_path(id: params['id'])
      return
    end

    cpu_limit = params['project']['cpu_limit']
    memory_limit = params['project']['memory_limit']

    # 0 means invalid input
    if cpu_limit.to_i <= 0 || memory_limit.to_i <= 0
      flash['Invalid cpu or memory limit'] = 'Please enter a valid number'
      redirect_to modify_project_path(id: params['id'])
      return
    end

    @project = Project.find(params['id'])
    @project.update(project_params)

    redirect_to project_path(@project)
  end

  def destroy 
    @project = Project.find(params['id'])
    @group_project_reference = GroupProjectReference.find(@project.group_project_reference_id)
    @project.destroy
    redirect_to group_project_path(@group_project_reference.id)
  end

  def project_params
    params.require(:project).permit(:name, :group_id, :resource_definitions, :cpu_limit, :memory_limit)
  end
end

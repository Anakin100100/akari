class ProjectsController < ApplicationController
    before_action :authenticate_teacher!

    def new  
    end

    def create 
        @group = Group.find(params["project"]["group_id"].to_i)
        cpu_limit = params["project"]["cpu_limit"]
        memory_limit = params["project"]["memory_limit"]
        # 0 means invalid input
        if cpu_limit.to_i == 0 or memory_limit.to_i == 0
            flash["Invalid cpu or memory limit"] = "Please enter a valid number"
            redirect_to new_project_path
            return
        end 
        reference = GroupProjectReference.new(
            name: params["project"]["name"],
            group_id: @group.id
        )
        reference.save
        @group.students.each do |student| 
            student_project = Project.new(
                name: "#{student.name}_#{student.surname}_#{@group.name}_#{params["project"]["name"]}", 
                cpu_limit: params["project"]["cpu_limit"].to_i, 
                memory_limit: params["project"]["memory_limit"].to_i,
                group_project_reference_id: reference.id,
            )
            student_project.student_id = student.id
            student_project.save 
            binding.pry
        end
        redirect_to group_path(@group)
    end

    def show 
        @project = Project.find(params["id"])
    end

    def project_params 
        params.require(:project).permit(:name, :group_id, :resource_definitions, :cpu_limit, :memory_limit)
    end
end

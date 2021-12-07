class ProjectsController < ApplicationController
    before_action :authenticate_teacher!

    def new  
    end

    def create 
        @group = Group.find(params["project"]["group_id"].to_i)
        cpu_limit = params["cpu_limit"]
        memory_limit = params["memory_limit"]
        if (Integer(cpu_limit, exception: false) == nil) == false || (Integer(memory_limit, exception: false) == nil) == false
            flash["Invalid cpu or memory limit"] = "Please enter a valid number"
            redirect_to new_project_path
            return
        end 
        @group.students.each do |student| 
            student_project = Project.new(name: "#{student.name}_#{student.surname}_#{@group.name}_#{params["project"]["name"]}", group_id: @group.id, resource_definitions: params["project"]["resource_definitions"], cpu_limit: cpu_limit, memory_limit: memory_limit)
            student_project.student_id = student.id
            student_project.save 
        end
        redirect_to group_path(@group)
    end

    def project_params 
        params.require(:project).permit(:name, :group_id, :resource_definitions, :cpu_limit, :memory_limit)
    end
end

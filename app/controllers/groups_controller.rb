class GroupsController < ApplicationController
    before_action :authenticate_teacher!

    def index
        @groups = Group.all.where(teacher_id: current_teacher.id)
    end

    def new 
    end

    def create
        @group = Group.new(name: params["group"]["name"])
        @group.teacher_id = current_teacher.id
        invalid_names = []
        params["group"]["students_names"].split("\n").each do |student_email|
            if Student.where(email: student_email).empty?
                invalid_names << student_email
            else
                @group.students << Student.where(email: student_email)
            end
            binding.pry
        end
        if invalid_names.empty? == false
            flash[:Student_validation_error] = "The following students have invalid email addresses: #{invalid_names.join(', ')}"
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

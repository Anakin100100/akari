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
        binding.pry
        if @group.save
            invalid_names = []
            params["group"]["students_names"].split("\n").each do |student_email|
                if Student.where(email: student_email).empty?
                    invalid_names << student_email
                else
                    @group.students << Student.where(email: student_email)
                end
            end
            if invalid_names.empty? == false
                flash[:Student_validation_error] = "The following students have invalid email addresses: #{invalid_names.join(', ')}"
                redirect_to new_group_path
                return
            end
            redirect_to groups_path
        else
            render :new
        end
    end

    def show
        @group = Group.find(params[:id])
    end

    def group_params 
        params.require(:group).permit(:name)
    end
end

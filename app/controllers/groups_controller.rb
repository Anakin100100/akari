class GroupsController < ApplicationController
    before_action :authenticate_teacher!

    def index
        @groups = Group.all.where(teacher_id: current_teacher.id)
    end

    def new 
    end

    def create
        @group = Group.new(group_params)
        @group.teacher_id = current_teacher.id
        if @group.save
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

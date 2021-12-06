class GroupsController < ApplicationController
    before_action :authenticate_teacher!

    def index
        @groups = Group.all.where(teacher_id: current_teacher.id)
    end
end

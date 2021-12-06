class GroupsController < ApplicationController
    before_action :authenticate_teacher!
end

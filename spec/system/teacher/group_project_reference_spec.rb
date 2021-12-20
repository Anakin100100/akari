# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Showing group project', type: :system do
    before(:each) do
        @teacher = create(:teacher)
        (1..5).each do |_i|
        @teacher.groups << create(:group, teacher_id: @teacher.id)
        end
        @teacher.groups.each do |group|
            group_project_reference = create(:group_project_reference, group_id: group.id)
            group.group_project_references << group_project_reference
            group.save
            group.students.each do |student|
                project = create(:project)
                project.group_project_reference_id = group_project_reference.id
                project.student_id = student.id
                project.save
        end
        group.save
        end

        @teacher.save
        sign_in @teacher 
        @group_project_reference = @teacher.groups.first.group_project_references.first
        visit("/group_project/#{@group_project_reference.id}")
    end

    it "setup works" do
        expect(page).to have_content("Projekt groupowy: #{@group_project_reference.name}")
    end
end

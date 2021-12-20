# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New group form', type: :system do
    before(:each) do
        @teacher = create(:teacher)
        (1..2).each do |_i|
            group = create(:group, teacher_id: @teacher.id)
            (1..2).each do |_j|
                group.students << create(:student)
            end
            group.save 
            @teacher.groups << group
            @teacher.save
        end
        @teacher.groups.each do |group|
            group_project_reference = create(:group_project_reference, group_id: group.id)
            group.group_project_references << group_project_reference
            group.save
            group.students.each do |student|
                project = create(:project,
                    group_project_reference_id: group_project_reference.id,
                    student_id: student.id
                )
            end
        end

        @teacher.save
        sign_in @teacher 
        @group_project_reference = @teacher.groups.first.group_project_references.first
        visit("/group_project/#{@group_project_reference.id}")
        @project = Project.where(group_project_reference_id: @group_project_reference.id).first
        click_link "#{@project.name}"
    end

    it "displays the correct cpu value" do
        expect(page).to have_content("CPU limit: #{@project.cpu_limit} mcpu (1/1000s of a cpu)")
        expect(page).to have_content("Memory limit: #{@project.memory_limit} MB")
        @student = Student.find(@project.student_id)
        expect(page).to have_content("Student: #{@student.name} #{@student.surname}")
        group_project_reference = GroupProjectReference.find(@project.group_project_reference_id)
        group = Group.where(id: group_project_reference.group_id)
        expect(page).to have_content("Group: #{group.first.name}")
    end
end

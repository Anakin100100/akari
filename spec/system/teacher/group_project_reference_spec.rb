# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Showing group project', type: :system do
    before(:each) do
        @teacher = create(:teacher)
        (1..1).each do |_i|
            group = create(:group, teacher_id: @teacher.id)
            (1..1).each do |_j|
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
    end

    it "has the name of the group project on the page" do
        expect(page).to have_content("#{@group_project_reference.name}")
    end

    it "displays the name of each project in the group project" do
        @group_project_reference.projects.each do |project|
            expect(page).to have_content(project.name)
        end
    end

    it "displays the name of each student in the group project" do
        @students = Project.where(group_project_reference_id: @group_project_reference.id).map(&:student)
        @students.each do |student|
            expect(page).to have_content(student.name)
        end
    end

    it "allows the teacher to delete the group project" do
        expect { click_link 'Usuń projekt grupowy' }.to change { Project.count }.by(-@group_project_reference.projects.count)
    end

    it "can redirect to group page" do
        click_link "Grupa #{@group_project_reference.group.name}"
        expect(page).to have_current_path("/groups/#{@group_project_reference.group.id}")
    end
end

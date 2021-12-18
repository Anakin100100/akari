# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Groups', type: :system do
    before(:each) do
        @teacher = create(:teacher)
        for i in 1..5 do 
            @teacher.groups << create(:group, teacher_id: @teacher.id)
        end
        for group in @teacher.groups do
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
        visit '/groups'
    end
    
    it 'contains the list of groups' do
        expect(page).to have_content("Grupy:")
    end

    it 'can redirect to main dashboard' do
        click_link "Dashboard"
        expect(page).to have_current_path("/teacher_dashboard")
    end

    it 'can redirect to creating a new group' do
        click_link "Nowa grupa"
        expect(page).to have_current_path("/new_group")
    end

    it 'lists each group that belongs to the teacher' do
        group = create(:group, teacher: @teacher)
        @teacher.groups.each do |group|
            expect(page).to have_content(group.name)
        end
    end

    it 'allows the teacher to view the group details' do
        group = @teacher.groups.first
        click_link group.name
        group.students.each do |student|
            expect(page).to have_contnet(
                "#{student.name} #{student.surname}"
            )
        end
        group.group_project_references.each do |group_project_reference|
            expect(page).to have_content(group_project_reference.name)
        end
    end

    it 'has new group project button' do 
        group = @teacher.groups.last
        click_link group.name
        expect(page).to have_content("Nowy projekt grupy")
        click_link "Nowy projekt grupy"
    end

    it 'has button that allows to go back to the dashboard' do
        group = @teacher.groups.first
        click_link group.name
        expect(page).to have_content("Dashboard")
        click_link "Dashboard"
        expect(page).to have_current_path("/teacher_dashboard")
    end

    it 'has button that allows the user to delete the group' do
        group = @teacher.groups.first
        click_link group.name
        expect(page).to have_content("Usuń grupę")
        expect {click_link 'Usuń grupę'}.to change{ Group.count }.by(-1)
    end
end
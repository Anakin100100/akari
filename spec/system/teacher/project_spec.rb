# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Project', type: :system do
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

    it "deletes a project when a delete button is clicked" do
        expect(page).to have_content("Usuń projekt")
        expect { click_link "Usuń projekt" }.to change { Project.count }.by(-1)
        expect(page).to have_content("#{@group_project_reference.name}")
    end

    describe "when a project is deleted" do
        before(:each) do
            click_link "Modyfikuj projekt"
        end
        it 'will not allow to update a project without a name' do
            fill_in('Name', with: '')
            click_button 'Update Project'
            expect(page).to have_content("name can't be empty")
        end
    
        it 'will not allow to update a project without a resource definitions' do
            fill_in('Resource definitions', with: '')
            click_button 'Update Project'
            expect(page).to have_content("resource definitions can't be empty")
        end
    
        it 'will not allow to update a project without a cpu or memory limit' do
            fill_in('Cpu limit', with: '')
            click_button 'Update Project'
            expect(page).to have_content('Invalid cpu or memory limit')
        end
    
        it 'will not allow to update a project with negative cpu limit' do
            fill_in 'Name', with: 'Project name'
            fill_in 'Resource definitions', with: 'Definition of resources to be created'
            fill_in 'Cpu limit', with: -1
            fill_in 'Memory limit', with: 1
            click_button 'Update Project'
            expect(page).to have_content('Invalid cpu or memory limit')
        end
    
        it 'will not allow to update a project with negative memory limit' do
            fill_in 'Name', with: 'Project name'
            fill_in 'Resource definitions', with: 'Definition of resources to be created'
            fill_in 'Cpu limit', with: 1
            fill_in 'Memory limit', with: -1
            click_button 'Update Project'
            expect(page).to have_content('Invalid cpu or memory limit')
        end
    
        it 'will not allow to update a project with non integer cpu limit' do
            fill_in 'Name', with: 'Project name'
            fill_in 'Resource definitions', with: 'Definition of resources to be created'
            fill_in 'Cpu limit', with: 'invalid cpu limit that is a string'
            fill_in 'Memory limit', with: -1
            click_button 'Update Project'
            expect(page).to have_content('Invalid cpu or memory limit')
        end
    
        it 'will not allow to update a project with non integer memory limit' do
            fill_in 'Name', with: 'Project name'
            fill_in 'Resource definitions', with: 'Definition of resources to be created'
            fill_in 'Cpu limit', with: 1
            fill_in 'Memory limit', with: 'invalid memory limit that is a string'
            click_button 'Update Project'
            expect(page).to have_content('Invalid cpu or memory limit')
        end
    
        it 'allows to update a project with valid parameters' do
            fill_in 'Name', with: 'Project name'
            fill_in 'Resource definitions', with: 'Definition of resources to be created'
            fill_in 'Cpu limit', with: 100
            fill_in 'Memory limit', with: 100
            click_button 'Update Project'
            expect(page).to have_content("Success")
        end
    end
end

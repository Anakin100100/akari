# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Groups', type: :system do
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
    visit '/groups'
  end

  it 'contains the list of groups' do
    expect(page).to have_content('Grupy:')
  end

  it 'can redirect to main dashboard' do
    click_link 'Dashboard'
    expect(page).to have_current_path('/teacher_dashboard')
  end

  it 'can redirect to creating a new group' do
    click_link 'Nowa grupa'
    expect(page).to have_current_path('/new_group')
  end

  it 'can redirect to group project page' do
    group = @teacher.groups.first
    click_link "#{group.name}"
    group_project_reference = group.group_project_references.first
    click_link "#{group_project_reference.name}"
    expect(page).to have_current_path("/group_project/#{group_project_reference.id}")
    expect(page).to have_content("#{group_project_reference.name}")
  end

  it 'lists each group that belongs to the teacher' do
    @teacher.groups.each do |group|
      expect(page).to have_content(group.name)
    end
  end

  it 'allows the teacher to view the group details' do
    group = @teacher.groups.first
    click_link group.name
    group.students.each do |student|
      expect(page).to have_content("#{student.name} #{student.surname}")
    end
    group.group_project_references.each do |group_project_reference|
      expect(page).to have_content(group_project_reference.name)
    end
  end

  it 'has new group project button' do
    group = @teacher.groups.last
    click_link group.name
    expect(page).to have_content('Nowy projekt grupy')
    click_link 'Nowy projekt grupy'
  end

  it 'has button that allows to go back to the dashboard' do
    group = @teacher.groups.first
    click_link group.name
    expect(page).to have_content('Dashboard')
    click_link 'Dashboard'
    expect(page).to have_current_path('/teacher_dashboard')
  end

  it 'has button that allows the user to delete the group' do
    group = @teacher.groups.first
    click_link group.name
    expect(page).to have_content('Usuń grupę')
    expect { click_link 'Usuń grupę' }.to change { Group.count }.by(-1)
  end

  describe 'when creating a new project' do
    before(:each) do
      group = @teacher.groups.last
      click_link group.name
      click_link 'Nowy projekt grupy'
    end

    it 'will not allow to create a project without a name' do
      click_button 'Save Project'
      expect(page).to have_content("name can't be empty")
    end

    it 'will not allow to create a project without a resource definitions' do
      fill_in 'Name', with: 'Project name'
      click_button 'Save Project'
      expect(page).to have_content("resource definitions can't be empty")
    end

    it 'will not allow to create a project without a cpu or memory limit' do
      fill_in 'Name', with: 'Project name'
      fill_in 'Resource definitions', with: 'Definition of resources to be created'
      click_button 'Save Project'
      expect(page).to have_content('Invalid cpu or memory limit')
    end

    it 'will not allow to create a project with negative cpu limit' do
      fill_in 'Name', with: 'Project name'
      fill_in 'Resource definitions', with: 'Definition of resources to be created'
      fill_in 'Cpu limit', with: -1
      fill_in 'Memory limit', with: 1
      click_button 'Save Project'
      expect(page).to have_content('Invalid cpu or memory limit')
    end

    it 'will not allow to create a project with negative memory limit' do
      fill_in 'Name', with: 'Project name'
      fill_in 'Resource definitions', with: 'Definition of resources to be created'
      fill_in 'Cpu limit', with: 1
      fill_in 'Memory limit', with: -1
      click_button 'Save Project'
      expect(page).to have_content('Invalid cpu or memory limit')
    end

    it 'will not allow to create a project with non integer cpu limit' do
      fill_in 'Name', with: 'Project name'
      fill_in 'Resource definitions', with: 'Definition of resources to be created'
      fill_in 'Cpu limit', with: 'invalid cpu limit that is a string'
      fill_in 'Memory limit', with: -1
      click_button 'Save Project'
      expect(page).to have_content('Invalid cpu or memory limit')
    end

    it 'will not allow to create a project with non integer memory limit' do
      fill_in 'Name', with: 'Project name'
      fill_in 'Resource definitions', with: 'Definition of resources to be created'
      fill_in 'Cpu limit', with: 1
      fill_in 'Memory limit', with: 'invalid memory limit that is a string'
      click_button 'Save Project'
      expect(page).to have_content('Invalid cpu or memory limit')
    end

    it 'allows to create a project with valid parameters' do
        fill_in 'Name', with: 'Project name'
        fill_in 'Resource definitions', with: 'Definition of resources to be created'
        fill_in 'Cpu limit', with: 100
        fill_in 'Memory limit', with: 100
        click_button 'Save Project'
        expect(page).to have_content("Project creation successful")
    end
  end
end

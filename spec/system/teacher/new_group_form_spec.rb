# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New group form', type: :system do
    before(:each) do
        @teacher = create(:teacher)
        sign_in @teacher
        visit '/new_group'
        @student_1 = create(:student)
        @student_2 = create(:student)
    end

    it 'will not allow you to create a group without a name' do
        fill_in "Name", with: ""
        fill_in "Students names", with: ""
        click_button "Save Group"
        expect(page).to have_content("Nie można utworzyć grupy bez nazwy")
    end
    
    it 'will not allow you to create a group with a name that already exists' do
        first_group = create(:group, teacher_id: @teacher.id, name: "Grupa 1")
        fill_in "Name", with: "Grupa 1"
        fill_in "Students names", with: @student_1.name
        click_button "Save Group"
        expect(page).to have_content("Grupa o takiej nazwie już istnieje")
    end

    it "will allow you to create a group with a valid name and list of students" do
        fill_in "Name", with: "Nowa grupa"
        fill_in "Students names", with: "#{@student_1.email}\n#{@student_2.email}"
        expect { click_button "Save Group" }.to change { Group.count }.by(1)
        expect(page).to have_content("Nowa grupa")
    end

    it "will not allow you to create a group with a student email that doesn't exist" do
        fill_in "Name", with: "Nowa grupa"
        fill_in "Students names", with: "student_that_does_not_exist@gmail.com"
        click_button "Save Group"
        expect(page).to have_content("The following students have invalid email addresses: student_that_does_not_exist@gmail.com")
    end
end

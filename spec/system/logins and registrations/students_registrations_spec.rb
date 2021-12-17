# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Student registrations', type: :system do
  it 'contains the registration prompt' do
    visit '/students/sign_up'
    expect(page).to have_content('Register')
  end

  it 'contains the copyright notice' do
    visit '/students/sign_up'
    expect(page).to have_content('©2021 Paweł Biegun. All rights reserved.')
  end

  it 'allows a student to register' do
    visit '/students/sign_up'
    student = build(:student)
    fill_in 'Email', with: student.email
    fill_in 'Name', with: student.name
    fill_in 'Surname', with: student.surname
    fill_in 'Password', with: student.password
    fill_in 'Password confirmation', with: student.password
    expect {click_button('Sign Up')}.to change{ Student.count }.by(1)
    expect(page).to have_content("Student dashboard")
  end
end
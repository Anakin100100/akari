# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Teacher registrations', type: :system do
  it 'contains the registration prompt' do
    visit '/teachers/sign_up'
    expect(page).to have_content('Register')
  end

  it 'contains the copyright notice' do
    visit '/teachers/sign_up'
    expect(page).to have_content('©2021 Paweł Biegun. All rights reserved.')
  end

  it 'allows a teacher to register' do
    visit '/teachers/sign_up'
    teacher = build(:teacher)
    fill_in 'Email', with: teacher.email
    fill_in 'Name', with: teacher.name
    fill_in 'Surname', with: teacher.surname
    fill_in 'Password', with: teacher.password
    fill_in 'Password confirmation', with: teacher.password
    expect {click_button('Sign Up')}.to change{ Teacher.count }.by(1)
    expect(page).to have_content("Grupy")
  end
end
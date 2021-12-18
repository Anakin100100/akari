# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Student logins', type: :system do
  it 'contains the login prompt' do
    visit '/students/sign_in'
    expect(page).to have_content('Log In')
  end

  it 'contains the copyright notice' do
    visit '/students/sign_in'
    expect(page).to have_content('©2021 Paweł Biegun. All rights reserved.')
  end

  it 'allows a student to login' do
    visit '/students/sign_in'
    student = create(:student)
    fill_in 'Email', with: student.email
    fill_in 'Password', with: student.password
    click_button('Log in')
    expect(page).to have_content('Student dashboard')
  end
end

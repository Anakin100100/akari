# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Teacher registrations', type: :system do
  it 'contains the login prompt' do
    visit '/teachers/sign_in'
    expect(page).to have_content('Log In')
  end

  it 'contains the copyright notice' do
    visit '/teachers/sign_in'
    expect(page).to have_content('©2021 Paweł Biegun. All rights reserved.')
  end

  it 'allows a Teacher to login' do
    visit '/teachers/sign_in'
    teacher = create(:teacher)
    fill_in 'Email', with: teacher.email
    fill_in 'Password', with: teacher.password
    click_button('Log in')
    expect(page).to have_content("Grupy")
  end
end
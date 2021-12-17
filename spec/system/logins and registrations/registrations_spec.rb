# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :system do
  it 'contains the registration prompt' do
    visit '/registrations'
    expect(page).to have_content('Zarejestruj się jako:')
  end

  it 'contains the button to login as a student' do
    visit '/registrations'
    expect(page).to have_selector(:link_or_button, 'Uczeń')
  end

  it 'contains the button to login as a teacher' do
    visit '/registrations'
    expect(page).to have_selector(:link_or_button, 'Nauczyciel')
  end

  it 'redirects to student registration page when student button is clicked' do
    visit '/registrations'
    click_link 'Uczeń'
    expect(page).to have_current_path('/students/sign_up')
  end

  it 'redirecto to teacher login page when teacher button is clicked' do
    visit '/registrations'
    click_link 'Nauczyciel'
    expect(page).to have_current_path('/teachers/sign_up')
  end
end
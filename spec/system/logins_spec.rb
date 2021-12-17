# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Logins', type: :system do
  it 'contains the login prompt' do
    visit '/logins'
    expect(page).to have_content('Zaloguj się jako:')
  end

  it 'contains the button to login as a student' do
    visit '/logins'
    expect(page).to have_selector(:link_or_button, 'Uczeń')
  end

  it 'contains the button to login as a teacher' do
    visit '/logins'
    expect(page).to have_selector(:link_or_button, 'Nauczyciel')
  end

end
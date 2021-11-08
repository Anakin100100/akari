# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Landings', type: :system do
  it 'load the landing page', :js do
    login_as(create(:teacher))

    visit root_path

    expect(page).to have_content('WELCOME TO AKARI')
  end
end

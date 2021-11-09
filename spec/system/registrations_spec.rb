require 'rails_helper'

RSpec.describe "Registrations", type: :system do
  it "has 'Zarejestruj się jako' " do 
    visit "/registrations"
    expect(page).to have_content("Zarejestruj się jako")
    expect(page).to have_content("Nauczyciel")
    expect(page).to have_content("Uczeń")
    expect(page).to have_content("Rodzic")
  end
end

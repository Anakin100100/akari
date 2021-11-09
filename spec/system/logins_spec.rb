require 'rails_helper'

RSpec.describe "Logins", type: :system do
  it "has 'Zaloguj się jako' " do 
    visit "/logins"
    expect(page).to have_content("Zaloguj się jako")
    expect(page).to have_content("Nauczyciel")
    expect(page).to have_content("Uczeń")
    expect(page).to have_content("Rodzic")
  end
end

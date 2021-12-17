# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Teacher dashboard', type: :system do
    it 'contains the groups button' do
        teacher = create(:teacher)
        sign_in teacher
        visit '/teacher_dashboard'
        expect(page).to have_content("Grupy")
    end
end
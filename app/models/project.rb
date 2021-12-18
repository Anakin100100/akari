# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :student
  belongs_to :group_project_reference
end

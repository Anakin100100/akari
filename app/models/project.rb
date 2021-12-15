class Project < ApplicationRecord
    belongs_to :student
    has_one :group_project_reference
end

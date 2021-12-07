class Project < ApplicationRecord
    belongs_to :student
    belongs_to :group
    has_one :group_project_reference
end

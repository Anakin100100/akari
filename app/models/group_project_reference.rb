class GroupProjectReference < ApplicationRecord
    has_many :projects
    belongs_to :group
end

# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :teacher
  has_and_belongs_to_many :students
  has_many :group_project_references, dependent: :destroy
end

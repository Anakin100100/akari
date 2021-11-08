# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :teacher
  has_many :students, dependent: :destroy
end

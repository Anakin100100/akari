# frozen_string_literal: true

class GroupProjectReference < ApplicationRecord
  has_many :projects, dependent: :destroy
  belongs_to :group
end

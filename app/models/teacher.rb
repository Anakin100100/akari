# frozen_string_literal: true

class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :timeoutable, :validatable
  has_many :groups, dependent: :destroy
  has_many :students, through: :groups
end

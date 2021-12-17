# frozen_string_literal: true

class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :timeoutable, :validatable
  has_and_belongs_to_many :groups
  has_many :teachers, through: :groups
  has_many :projects, dependent: :destroy
end

# frozen_string_literal: true

class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :group
  has_many :parents, through: :parents_students
  has_one :flashcard_session, dependent: :destroy
end

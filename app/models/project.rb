class Project < ApplicationRecord
  belongs_to :company, optional: true
  has_many :auditions
  belongs_to :user

  validates :name, presence: true
end

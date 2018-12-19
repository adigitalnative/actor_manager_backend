class Project < ApplicationRecord
  belongs_to :company, optional: true
  has_many :auditions
  belongs_to :user
  belongs_to :result, optional: true

  validates :name, presence: true
end

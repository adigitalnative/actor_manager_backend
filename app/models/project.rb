class Project < ApplicationRecord
  belongs_to :company, optional: true
  has_many :auditions

  validates :name, presence: true
end

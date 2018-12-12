class Project < ApplicationRecord
  belongs_to :company, optional: true

  validates :name, presence: true
end

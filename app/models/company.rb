class Company < ApplicationRecord

  has_many :projects
  belongs_to :user

  validates :name, presence: true

end

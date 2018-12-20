class Result < ApplicationRecord

  has_many :projects

  validates :name, presence: true
  validates :booked, inclusion: [true, false]

end

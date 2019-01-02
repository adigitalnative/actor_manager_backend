class Opportunity < ApplicationRecord
  belongs_to :state

  validates :source, presence: true
  validates :title, presence: true
  validates :url, presence: true
  validates :company, presence: true
  validates :active, inclusion: { in: [true, false]}
end

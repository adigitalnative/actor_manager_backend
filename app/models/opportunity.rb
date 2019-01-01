class Opportunity < ApplicationRecord
  belongs_to :company
  belongs_to :state

  validates :source, presence: true
  validates :title, presence: true
  validates :url, presence: true

  
end

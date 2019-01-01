class State < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  # validates :search, presence: true, inclusion: [in: [true, false]]

  def self.to_scrape
    State.where(search: true)
  end
end

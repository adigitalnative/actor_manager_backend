class Audition < ApplicationRecord

  validates :bring, presence: true
  validates :prepare, presence: true

end

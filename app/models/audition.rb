class Audition < ApplicationRecord

  belongs_to :project
  belongs_to :category
  belongs_to :user
  has_one :report

  validates :bring, presence: true
  validates :prepare, presence: true

  def company
    project.company
  end

end

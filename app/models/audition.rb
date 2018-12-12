class Audition < ApplicationRecord

  belongs_to :project, optional: true

  validates :bring, presence: true
  validates :prepare, presence: true

  def company
    project ? project.company : nil
  end

end

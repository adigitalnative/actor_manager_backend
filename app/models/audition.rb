class Audition < ApplicationRecord

  belongs_to :project
  belongs_to :category
  belongs_to :user
  has_one :report, dependent: :destroy

  validates :bring, presence: true
  validates :prepare, presence: true

  after_create :create_associated_report

  def company
    project.company
  end

  def create_associated_report
    create_report
  end

end

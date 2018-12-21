class Audition < ApplicationRecord

  belongs_to :project
  belongs_to :category
  belongs_to :user
  has_one :report, dependent: :destroy
  has_many :audition_pieces, dependent: :destroy
  has_many :book_items, through: :audition_pieces

  alias_attribute :pieces, :book_items

  accepts_nested_attributes_for :book_items

  validates :bring, presence: true
  validates :prepare, presence: true

  after_create :create_associated_report

  def has_report?
    if report.notes || report.people || report.auditors
      true
    else
      false
    end
  end

  def company
    project.company
  end

  def create_associated_report
    create_report
  end

  def self.percent_reported(user)
    user_auditions = user.auditions
    reported = 0

    user_auditions.each do |audition|
      if audition.has_report?
        reported += 1
      end
    end

    if user_auditions.count == 0
      return "N/A"
    elsif reported == 0
      return 0
    elsif reported < user_auditions.count
      find_percentage(reported, user_auditions.count)
    else
      return 100
    end
  end

  def self.find_percentage(amount, total)
    (amount.to_f / total.to_f * 100).to_i
  end

end

class Project < ApplicationRecord
  belongs_to :company, optional: true
  has_many :auditions
  belongs_to :user
  belongs_to :result, optional: true

  validates :name, presence: true

  class Numeric
    def percent_of(n)
      self.to_f / n.to_f * 100.0
    end
  end

# 1.percent_of 10    # => 10.0  (%)

  def self.find_percentage(amount, total)
    (amount.to_f / total.to_f * 100).to_i
  end

  def self.percent_booked(user_id)
    users_projects = where(user_id: user_id)
    booked = 0
    reported = 0

    users_projects.each do |project|
      if project.result && project.result.booked?
        booked += 1
        reported += 1
      elsif project.result
        reported += 1
      end
    end

    if booked == 0
      return "N/A"
    elsif booked == reported
      return 100
    else
      find_percentage(booked, reported)
    end
  end
end

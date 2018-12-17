class Report < ApplicationRecord
  belongs_to :audition
  belongs_to :result, optional: true

  def result_text
    result ? result.name : nil
  end
end

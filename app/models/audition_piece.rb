class AuditionPiece < ApplicationRecord
  belongs_to :book_item
  belongs_to :audition
end

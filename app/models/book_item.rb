class BookItem < ApplicationRecord
  belongs_to :user
  has_many :audition_pieces, dependent: :destroy
  has_many :auditions, through: :audition_pieces

  validates :title, presence: true
end

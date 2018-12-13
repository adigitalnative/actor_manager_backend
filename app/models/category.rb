class Category < ApplicationRecord

  has_many :auditions
  
  validates :name, presence: true

end

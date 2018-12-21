class User < ApplicationRecord
  has_secure_password

  after_create :create_sides_book_item

  has_many :auditions
  has_many :projects
  has_many :companies
  has_many :book_items

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password_digest, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def create_sides_book_item
    book_items.create(title: "Prepared Sides")
  end

  def percent_booked
    Project.percent_booked(id)
  end

  def percent_reported
    Audition.percent_reported(self)
  end

  def potential_bookings
    projects.where(result: nil).count
  end

end

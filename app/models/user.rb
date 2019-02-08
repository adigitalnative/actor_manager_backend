class User < ApplicationRecord
  has_secure_password

  after_create :create_sides_book_item

  after_save :mark_states_for_search

  has_many :auditions
  has_many :projects
  has_many :companies
  has_many :book_items
  has_many :search_states
  has_many :states, through: :search_states
  has_many :leads

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

  # Set search: true for any states associated with this user.
  # TODO: Scrape for new opportunities for any new states
  # TODO: Not specc'd for the moment. Needs specs
  def mark_states_for_search
    new_states = self.states.where(search: false)
    # Comment out next line to turn off source-on-demand for demo/speed purposes
    Opportunity.source_opportunities(new_states.map {|s| s.name})
    new_states.update_all(search: true)
  end

end

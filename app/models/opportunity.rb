class Opportunity < ApplicationRecord
  belongs_to :state

  validates :source, presence: true
  validates :title, presence: true
  validates :url, presence: true
  validates :company, presence: true
  validates :active, inclusion: { in: [true, false]}

  # These are not yet tested. Be aware.
  def self.source_global_opportunities
    states = State.to_scrape.map {|state| state.name }

    self.source_opportunities(states)
  end

  def self.source_opportunities(states)
    opportunities = Thespis::Runner.search(states)
    opportunities.each do |opportunity|
      state = State.find_by_name(opportunity[:state])
      Opportunity.find_or_create_by(source: opportunity[:source], title: opportunity[:title], company: opportunity[:company], url: opportunity[:url], state: state)
    end
  end
end

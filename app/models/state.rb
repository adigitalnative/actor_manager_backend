class State < ApplicationRecord

  has_many :search_states
  has_many :users, through: :search_states

  validates :name, presence: true, uniqueness: true
  # validates :search, presence: true, inclusion: [in: [true, false]]

  def self.to_scrape
    states = State.where(search: true)
    clean_dead_search_states(states)
  end

  private

  def self.clean_dead_search_states(states_to_check)
    states = []
    states_to_check.each do |state|
      if state.users.count == 0
        state.update(search: false)
      else
        states << state
      end
    end

    return states
  end

end

class Lead < ApplicationRecord
  belongs_to :opportunity
  belongs_to :user
  has_one :audition

  validates :new, inclusion: {in: [true, false]}
  validates :archived, inclusion: {in: [true, false]}

  def archive
    update(archived: true)
  end

  def self.generate_for(user)
    # Find leads for the user & set any w/ new: true to false
    # TODO: Move this to a method on a user
    leads = user.leads
    leads.update_all(new: false)

    # Pull all of the user's lead opportunities
    previous_opps = leads.map {|lead| lead.opportunity }

    # Pull all new opportunities for the users' states
    new_opps = user.states.map do |state|
      state.opportunities.where(active: true)
    end
    new_opps = new_opps.flatten

    # Go through the new opportunities. If user doesn't have as a lead, make it a lead.
    new_opps.each do |opportunity|
      if !previous_opps.include?(opportunity)
        user.leads.create(opportunity: opportunity)
      end
    end

    # Because the thing ran cleanly, return true
    return true
  end
end

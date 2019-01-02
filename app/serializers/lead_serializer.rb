class LeadSerializer < ActiveModel::Serializer
  attributes :id, :new, :archived, :audition
  belongs_to :opportunity

  def audition
    if object.audition
      true
    else
      false
    end
  end

end

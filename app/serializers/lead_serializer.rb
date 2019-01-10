class LeadSerializer < ActiveModel::Serializer
  attributes :id, :new, :archived
  belongs_to :opportunity
  has_one :audition

end

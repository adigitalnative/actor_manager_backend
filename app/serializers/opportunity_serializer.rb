class OpportunitySerializer < ActiveModel::Serializer
  attributes :id, :source, :title, :company, :url

  def state
    object.state.name
  end
end

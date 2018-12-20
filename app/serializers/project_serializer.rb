class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :result
  belongs_to :company
end

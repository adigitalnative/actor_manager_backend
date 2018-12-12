class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name
  belongs_to :company
end

class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :report
  belongs_to :company
end

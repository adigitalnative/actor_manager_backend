class DashboardSerializer < ActiveModel::Serializer
  has_many(:projects, serializer: ProjectsSerializer)
end

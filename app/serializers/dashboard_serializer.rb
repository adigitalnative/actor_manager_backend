class DashboardSerializer < ActiveModel::Serializer
  attributes :percent_booked
  has_many(:projects, serializer: ProjectsSerializer)
end

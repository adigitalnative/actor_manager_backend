class DashboardSerializer::ProjectsSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to(:company, serializer: DashboardSerializer::ProjectsSerializer::CompanySerializer)
  has_many(:auditions, serializer: AuditionsSerializer)
  belongs_to(:result, serializer: ResultSerializer)
end

class DashboardSerializer::ProjectsSerializer::AuditionsSerializer < ActiveModel::Serializer
  attributes :id, :date_and_time, :category

  def category
    object.category.name
  end
end

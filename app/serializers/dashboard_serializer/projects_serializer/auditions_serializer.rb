class DashboardSerializer::ProjectsSerializer::AuditionsSerializer < ActiveModel::Serializer
  attributes :id, :date, :category, :project_name

  has_one :report

  def category
    object.category.name
  end

  def date
    if object.date_and_time
      object.date_and_time.strftime('%a, %b %e, %Y')
    else
      nil
    end
  end

  def project_name
    object.project.name
  end
end

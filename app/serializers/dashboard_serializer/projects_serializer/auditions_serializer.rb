class DashboardSerializer::ProjectsSerializer::AuditionsSerializer < ActiveModel::Serializer
  attributes :id, :date, :category

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
end

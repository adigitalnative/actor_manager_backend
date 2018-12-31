class DashboardSerializer < ActiveModel::Serializer
  # object is a user class

  attributes :percent_booked, :project_count, :audition_count, :percent_reported, :potential_bookings

  has_many(:projects, serializer: ProjectsSerializer)

  def project_count
    object.projects.count
  end

  def audition_count
    object.auditions.count
  end

  def projects
    object.projects.order(:name)
  end
end

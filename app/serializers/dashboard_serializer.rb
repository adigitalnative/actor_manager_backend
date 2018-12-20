class DashboardSerializer < ActiveModel::Serializer
  # object is a user class

  attributes :percent_booked, :project_count, :audition_count

  has_many(:projects, serializer: ProjectsSerializer)

  def project_count
    object.projects.count
  end

  def audition_count
    object.auditions.count
  end
end

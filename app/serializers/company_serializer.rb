class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :projects

  def projects
    # Eventually projects may need to have some date values and sort by these?
    object.projects.order(:name)
  end
end

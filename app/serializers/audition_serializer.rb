class AuditionSerializer < ActiveModel::Serializer
  attributes :id, :bring, :prepare, :project, :company, :category

  def project
    object.project.name
  end

  def company
    if object.project.company
      object.project.company.name
    else
      ""
    end
  end

  def category
    object.category.name
  end
end

class AuditionSerializer < ActiveModel::Serializer
  attributes :id, :bring, :prepare, :project, :company, :category, :result
  has_one :report
  has_many :pieces

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

  def result
    if object.project.result
      object.project.result
    else
      {}
    end
  end

  def category
    object.category.name
  end

end

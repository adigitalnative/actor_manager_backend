class AuditionSerializer < ActiveModel::Serializer
  attributes :id, :bring, :prepare, :project, :company, :category, :result, :dateTime
  has_one :report
  has_many :pieces

  def dateTime
    if object.date_and_time
      object.date_and_time.strftime('%a, %b %e, %Y at %l:%M %P')
    else
      nil
    end
  end

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

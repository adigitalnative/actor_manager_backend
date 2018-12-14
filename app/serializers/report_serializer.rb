class ReportSerializer < ActiveModel::Serializer
  attributes :id, :notes, :people, :auditors, :result

  def result
    object.result_text
  end
end

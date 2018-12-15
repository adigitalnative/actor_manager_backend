class ReportSerializer < ActiveModel::Serializer
  attributes :id, :notes, :people, :auditors, :result
end

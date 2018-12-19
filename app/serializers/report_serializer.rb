class ReportSerializer < ActiveModel::Serializer
  attributes :id, :notes, :people, :auditors
end

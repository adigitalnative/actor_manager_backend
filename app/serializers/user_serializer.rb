class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :first_name, :last_name

  def full_name
    [object.first_name, object.last_name].join(" ")
  end
end

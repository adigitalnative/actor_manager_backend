class BookItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :role, :author, :display_title

  def display_title
    if object.role
      return object.title + " (" + object.role + ")"
    else
      return object.title
    end
  end
end

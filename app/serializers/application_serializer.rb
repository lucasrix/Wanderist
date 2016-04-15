class ApplicationSerializer < ActiveModel::Serializer
  alias current_user scope
end

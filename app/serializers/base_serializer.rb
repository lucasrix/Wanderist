class BaseSerializer < ActiveModel::Serializer
  attributes :status

  has_one :error, serializer: ErrorSerializer
end